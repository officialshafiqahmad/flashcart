import 'package:cirilla/constants/strings.dart';
import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/models/models.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cirilla/screens/product_list/widgets/sort.dart' show listSortBy;

import '../product/product.dart';

class ProductFeaturedWidget extends StatefulWidget {
  final WidgetConfig? widgetConfig;

  const ProductFeaturedWidget({
    Key? key,
    this.widgetConfig,
  }) : super(key: key);

  @override
  State<ProductFeaturedWidget> createState() => _ProductFeaturedState();
}

class _ProductFeaturedState extends State<ProductFeaturedWidget> with Utility, ContainerMixin {
  late AppStore _appStore;
  SettingStore? _settingStore;
  AuthStore? _authStore;
  ProductsStore? _productsStore;

  @override
  void didChangeDependencies() {
    _appStore = Provider.of<AppStore>(context);
    _authStore = Provider.of<AuthStore>(context);
    _settingStore = Provider.of<SettingStore>(context);

    Map<String, dynamic> fields = widget.widgetConfig?.fields ?? {};

    // Filter
    int limit = ConvertData.stringToInt(get(fields, ['limit'], '4'));
    List<dynamic> excludeProduct = get(fields, ['excludeProduct'], []);
    bool enableGeoSearch = ConvertData.toBoolValue(get(fields, ['enableGeoSearch'])) ?? true;

    // Gen key for store
    List<Product> exProducts = excludeProduct.map((e) => Product(id: ConvertData.stringToInt(e['key']))).toList();

    String? key = StringGenerate.getProductKeyStore(
      widget.widgetConfig!.id,
      currency: _settingStore!.currency,
      language: _settingStore!.locale,
      excludeProduct: exProducts,
      limit: limit,
      enableGeoSearch: enableGeoSearch,
    );

    String randomProduct = get(fields, ['sortBy'], 'latest');

    // Add store to list store
    if (widget.widgetConfig != null && _appStore.getStoreByKey(key) == null) {
      ProductsStore store = ProductsStore(
        _settingStore!.requestHelper,
        key: key,
        perPage: limit,
        featured: true,
        sort: randomProduct == 'random'
            ? Map<String, dynamic>.from({
                'key': 'product_list_random',
                'translate_name': 'product_list_random',
                'query': {
                  'orderby': 'rand',
                  'order': 'desc',
                }
              })
            : listSortBy[4],
        exclude: exProducts,
        language: _settingStore!.locale,
        currency: _settingStore!.currency,
        locationStore: enableGeoSearch ? _authStore?.locationStore : null,
      )..getProducts();
      _appStore.addStore(store);
      _productsStore ??= store;
    } else {
      _productsStore = _appStore.getStoreByKey(key);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    String themeModeKey = _settingStore?.themeModeKey ?? 'value';

    // Item style
    WidgetConfig configs = widget.widgetConfig!;

    // Item template
    String layout = configs.layout ?? Strings.productLayoutList;

    // Style
    Map<String, dynamic>? margin = get(configs.styles, ['margin'], {});
    Map<String, dynamic>? padding = get(configs.styles, ['padding'], {});
    Map<String, dynamic>? background = get(configs.styles, ['background', themeModeKey], {});

    return Container(
      margin: ConvertData.space(margin, 'margin'),
      decoration: decorationColorImage(color: ConvertData.fromRGBA(background, Colors.transparent)),
      child: ProductWidget(
        fields: configs.fields,
        styles: configs.styles,
        productsStore: _productsStore,
        layout: layout,
        padding: ConvertData.space(padding, 'padding'),
      ),
    );
  }
}
