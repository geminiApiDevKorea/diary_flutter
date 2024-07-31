import 'package:diary_flutter/presentation/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomTextFormField extends HookConsumerWidget {
  final int maxLength;
  final int minLength;
  final String initialText;
  final bool isEditable;
  final Function(String value) onChangedInputText;
  const CustomTextFormField({
    super.key,
    required this.initialText,
    required this.isEditable,
    required this.maxLength,
    required this.minLength,
    required this.onChangedInputText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = GemTheme.of(ref).colors;
    final textStyle = GemTheme.of(ref).textStyle;
    final controller = useTextEditingController(text: initialText);
    final input = useState(initialText);
    useEffect(() {
      onChanged() {
        input.value = controller.text;
        onChangedInputText(input.value);
      }

      controller.addListener(onChanged);
      return () => controller.removeListener(onChanged);
    }, []);
    return Column(
      children: [
        Container(
          height: 39,
          decoration: BoxDecoration(
            color: colors.grayScale90,
            borderRadius: BorderRadius.circular(40),
            border: input.value.length >= minLength
                ? null
                : Border.all(
                    color: colors.error,
                    width: 1,
                  ),
          ),
          child: Transform.translate(
            offset: const Offset(0, -4),
            child: TextFormField(
              enabled: isEditable,
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                ),
                labelStyle: textStyle.h2,
              ),
              maxLines: 1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13.5, vertical: 10.0),
          child: Row(
            children: [
              if (input.value.length < minLength)
                Text(
                  'Please enter at least $minLength characters.',
                  style: textStyle.paragraph.withColor(colors.error),
                ),
              const Spacer(),
              Text(
                '${input.value.length}',
                style: textStyle.caption.withColor(colors.text),
              ),
              Text(
                '/$maxLength',
                style: textStyle.caption.withColor(colors.caption),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
