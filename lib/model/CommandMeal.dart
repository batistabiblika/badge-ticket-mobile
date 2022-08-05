// Ticket mifanaraka amin'ny command. Ito no mirepresenté ny ticket
import 'package:fbb_reg_ticket/model/Meal.dart';

class CommandMeal {
  int id;
  int quantity;
  int quantityConsumed;
  Meal meal;

  CommandMeal(this.id, this.quantity, this.quantityConsumed, this.meal);
}
