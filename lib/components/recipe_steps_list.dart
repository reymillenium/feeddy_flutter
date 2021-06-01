// Packages:
import 'package:feeddy_flutter/_inner_packages.dart';
import 'package:feeddy_flutter/_external_packages.dart';
// Screens:

// Models:
import 'package:feeddy_flutter/models/_models.dart';

// Components:
import 'package:feeddy_flutter/components/_components.dart';

// Helpers:
import 'package:feeddy_flutter/helpers/_helpers.dart';
// Utilities:

class RecipeStepsList extends StatelessWidget {
  // Properties:
  final _listViewScrollController = ScrollController();
  final foodRecipe;

  // Constructor:
  RecipeStepsList({
    Key key,
    this.foodRecipe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RecipeStepsData recipeStepsData = Provider.of<RecipeStepsData>(context, listen: true);

    return FutureBuilder<List<RecipeStep>>(
      future: recipeStepsData.byFoodRecipe(foodRecipe),
      builder: (ctx, snapshot) {
        List<RecipeStep> recipeSteps = snapshot.data;
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return recipeSteps.isEmpty
                ? FeeddyEmptyWidget(
                    packageImage: 1,
                    title: 'We are sorry',
                    subTitle: 'There is no recipe steps',
                  )
                : ListView.custom(
                    padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
                    controller: _listViewScrollController,
                    childrenDelegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return RecipeStepTile(
                          key: ValueKey(recipeSteps[index].id),
                          recipeStep: recipeSteps[index],
                          index: index,
                        );
                      },
                      childCount: recipeSteps.length,
                      // This callback method is what allows to preserve the state:
                      findChildIndexCallback: (Key key) => findChildIndexCallback(key, recipeSteps),
                    ),
                  );
          default:
            return Container(
              child: FeeddyEmptyWidget(
                packageImage: 1,
                title: 'We are sorry',
                subTitle: 'There is no recipe steps',
              ),
            );
        }
      },
    );
  }

  // This callback method is what allows to preserve the state:
  int findChildIndexCallback(Key key, List<RecipeStep> recipeSteps) {
    final ValueKey valueKey = key as ValueKey;
    final int id = valueKey.value;
    // final int id = int.parse(foodRecipeWidgetID.substring(0, 12));
    RecipeStep recipeStep;
    try {
      recipeStep = recipeSteps.firstWhere((recipeStep) => id == recipeStep.id);
    } catch (e) {
      return null;
    }
    return recipeSteps.indexOf(recipeStep);
  }
}
