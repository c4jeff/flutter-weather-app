import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/core/config/app_durations.dart';
import 'package:weather_app/l10n/app_error_messages.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';
import 'package:weather_app/features/location/domain/entities/location.dart';
import 'package:weather_app/features/location/presentation/providers/location_providers.dart';

class LocationSearchField extends ConsumerStatefulWidget {
  const LocationSearchField({required this.onSelected, super.key});

  final ValueChanged<Location> onSelected;

  @override
  ConsumerState<LocationSearchField> createState() =>
      _LocationSearchFieldState();
}

class _LocationSearchFieldState extends ConsumerState<LocationSearchField> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  Timer? _debounce;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (mounted) setState(() {});
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(AppDurations.searchDebounce, () {
      if (!mounted) return;
      setState(() => _query = value.trim());
    });
    setState(() {});
  }

  void _select(Location location) {
    _debounce?.cancel();
    _controller.text = location.name;
    setState(() => _query = '');
    _focusNode.unfocus();
    widget.onSelected(location);
  }

  void _clear() {
    _debounce?.cancel();
    _controller.clear();
    setState(() => _query = '');
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final language = Localizations.localeOf(context).languageCode;
    final request = (query: _query, language: language);
    final shouldSearch = _query.length >= 2 && _focusNode.hasFocus;
    final results = shouldSearch
        ? ref.watch(locationSearchProvider(request))
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          key: const Key('location-search-field'),
          controller: _controller,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          onChanged: _onChanged,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: l10n.searchLocationHint,
            prefixIcon: const Icon(Icons.search_rounded),
            suffixIcon: _controller.text.isEmpty
                ? null
                : IconButton(
                    tooltip: l10n.clearSearch,
                    onPressed: _clear,
                    icon: const Icon(Icons.close_rounded),
                  ),
          ),
        ),
        if (_focusNode.hasFocus && _controller.text.trim().length == 1)
          Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Text(l10n.enterMoreCharacters),
          ),
        if (results != null) ...[
          const SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 344),
              child: results.when(
                loading: () => const Padding(
                  padding: EdgeInsets.all(22),
                  child: Center(
                    child: SizedBox.square(
                      dimension: 24,
                      child: CircularProgressIndicator(strokeWidth: 2.5),
                    ),
                  ),
                ),
                error: (error, stackTrace) => Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          userMessageFor(l10n, error),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      TextButton(
                        onPressed: () =>
                            ref.invalidate(locationSearchProvider(request)),
                        child: Text(l10n.retry),
                      ),
                    ],
                  ),
                ),
                data: (locations) {
                  if (locations.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(22),
                      child: Center(child: Text(l10n.noLocationsFound)),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    itemCount: locations.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final location = locations[index];
                      return ListTile(
                        key: Key('location-${location.id}'),
                        leading: const CircleAvatar(
                          child: Icon(Icons.location_on_outlined),
                        ),
                        title: Text(location.name),
                        subtitle: Text(location.subtitle),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () => _select(location),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}
