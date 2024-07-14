import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

bool useIsTextEditingControllerEmpty(TextEditingController textEditController) {
  final isEmpty = useState(textEditController.text.isEmpty);
  useEffect(() {
    listener() => isEmpty.value = textEditController.text.isEmpty;
    textEditController.addListener(listener);
    return () => textEditController.removeListener(listener);
  }, []);
  return isEmpty.value;
}
