import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/extension/strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextWidget extends StatelessWidget with Utility, NavigationMixin, ContainerMixin {
  final WidgetConfig? widgetConfig;

  TextWidget({
    Key? key,
    required this.widgetConfig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingStore settingStore = Provider.of<SettingStore>(context);
    String themeModeKey = settingStore.themeModeKey;
    String languageKey = settingStore.languageKey;

    // Styles
    Map<String, dynamic> styles = widgetConfig?.styles ?? {};
    Map<String, dynamic>? margin = get(styles, ['margin'], {});
    Map<String, dynamic>? padding = get(styles, ['padding'], {});
    Map? background = get(styles, ['background', themeModeKey], {});

    // General config
    Map<String, dynamic> fields = widgetConfig?.fields ?? {};
    dynamic title = get(fields, ['title'], {});
    String? alignment = get(fields, ['alignment'], 'center');
    Map<String, dynamic>? action = get(fields, ['action'], {});

    String textTitle = ConvertData.textFromConfigs(title, languageKey);
    TextStyle styleTitle = ConvertData.toTextStyle(title, themeModeKey);
    Color backgroundColor = ConvertData.fromRGBA(background, Theme.of(context).cardColor);

    String? typeAction = get(action, ['type'], 'none');

    Widget itemText = Container(
      padding: ConvertData.space(padding, 'padding'),
      decoration: decorationColorImage(color: backgroundColor),
      child: Text(
        TextDynamic.getTextDynamic(context, text: textTitle.unescape),
        style: Theme.of(context).textTheme.bodyLarge?.merge(styleTitle),
        textAlign: ConvertData.toTextAlignDirection(alignment),
      ),
    );

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      child: InkWell(
        onTap: () => typeAction != 'none' ? navigate(context, action) : null,
        child: itemText,
      ),
    );
  }
}
