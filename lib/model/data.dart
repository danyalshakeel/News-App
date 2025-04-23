import 'package:new10/model/category_model.dart';

List<categoryModel> getcategory() {
  List<categoryModel> category = [];

  categoryModel cm = new categoryModel();

  cm.name = "Business";
  cm.categoryImage = "assets/image/busniess.jpg";
  category.add(cm);

  cm = new categoryModel();
  cm.name = "Entertainment";
  cm.categoryImage = "assets/image/entertainment.jpg";
  category.add(cm);

  cm = new categoryModel();
  cm.name = "Technology";
  cm.categoryImage = "assets/image/genral.jpg";
  category.add(cm);
  cm = new categoryModel();
  cm.name = "Health";
  cm.categoryImage = "assets/image/health.jpg";
  category.add(cm);

  cm = new categoryModel();
  cm.name = "Science";
  cm.categoryImage = "assets/image/science.jpg";
  category.add(cm);

  cm = new categoryModel();
  cm.name = "Sports";
  cm.categoryImage = "assets/image/sport.jpg";
  category.add(cm);

  return category;
}
