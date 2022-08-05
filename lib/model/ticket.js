// azo avy amin'ny GET http://...api/ticket/001a/consume
ticket = {
    "id" : 0000, // id an'ilay commande/ticket ngamba ito
    "consumeDate" : "01/01/2000", // daten'andron'ilay fisakafoanana sy ilay Meal
    "type": "SAKAFO MARAINA", //SAKAFO MARAINA, SAKAFO ATOANDRO, SAKAFO HARIVA, ilay type n ny meal angamba
    "mealGM" : { // info mikasika ny CommandMeal LEHIBE novidiana. Raha misy commandMeal maromaro ka size LEHIBE dia mba groupena ato
        "quantity": 2, // isa
        "quantityConsumed" : 0,
    },
    "mealPM" : { // info mikasika ny CommandMeal KELY novidiana. Raha misy commandMeal maromaro ka size LEHIBE dia mba groupena ato
        "quantity": 3, // isa
        "quantityConsumed" : 0,
    }
}


// Ito indray POST azo avy amin'ny POST http://...api/ticket/001a/consume
ticketAValider = {
    "id" : 0000, // id an'ilay commande/ticket ngamba ito
    "consumeDate" : "01/01/2000", // daten'andron'ilay fisakafoanana sy ilay Meal
    "type": "SAKAFO MARAINA", //SAKAFO MARAINA, SAKAFO ATOANDRO, SAKAFO HARIVA, ilay type n ny meal angamba
    "mealGM" : { // info mikasika ny CommandMeal LEHIBE hoanina
        "quantityToBeConsumed" : 2,
    },
    "mealPM" : { // info mikasika ny CommandMeal KELY hoanina
        "quantityToBeConsumed" : 3,
    }
}

// azo avy amin'ny GET http://...api/ticket/001a/verify
ticketResume = {
    "id" : 0000, // id an'ilay commande/ticket ngamba ito
    "badge" : {
        "id": 0001, // id badge
        "name": "Mirado A...",
    },
    "commandMeals": [
        {
            "id" : 0000, // id an'ilay commande/ticket ngamba ito
            "consumeDate" : "01/01/2000", // daten'andron'ilay fisakafoanana sy ilay Meal
            "type": "SAKAFO MARAINA", //SAKAFO MARAINA, SAKAFO ATOANDRO, SAKAFO HARIVA, ilay type n ny meal angamba
            "mealGM" : { // info mikasika ny CommandMeal LEHIBE novidiana. Raha misy commandMeal maromaro ka size LEHIBE dia mba groupena ato
                "quantity": 2, // isa
                "quantityConsumed" : 0,
            },
            "mealPM" : { // info mikasika ny CommandMeal KELY novidiana. Raha misy commandMeal maromaro ka size LEHIBE dia mba groupena ato
                "quantity": 3, // isa
                "quantityConsumed" : 0,
            }
        },
        {
            "id" : 0000, // id an'ilay commande/ticket ngamba ito
            "consumeDate" : "01/01/2000", // daten'andron'ilay fisakafoanana sy ilay Meal
            "type": "SAKAFO ATOANDRO", //SAKAFO MARAINA, SAKAFO ATOANDRO, SAKAFO HARIVA, ilay type n ny meal angamba
            "mealGM" : { // info mikasika ny CommandMeal LEHIBE novidiana. Raha misy commandMeal maromaro ka size LEHIBE dia mba groupena ato
                "quantity": 2, // isa
                "quantityConsumed" : 0,
            },
            "mealPM" : { // info mikasika ny CommandMeal KELY novidiana. Raha misy commandMeal maromaro ka size LEHIBE dia mba groupena ato
                "quantity": 3, // isa
                "quantityConsumed" : 0,
            }
        },
        //...
    ]
}