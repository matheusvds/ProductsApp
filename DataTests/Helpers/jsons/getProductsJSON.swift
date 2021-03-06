
let getProductsJSON =
"""
{
    "products": [{
        "identifier": 234,
        "name": "Buggati Veyron",
        "brand": "Buggati",
        "original_price": 600000,
        "current_price": 100000,
        "currency": "EUR",
        "image": {
            "id": 101,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Bugatti_Veyron_16.4_%E2%80%93_Frontansicht_%281%29%2C_5._April_2012%2C_D%C3%BCsseldorf.jpg/280px-Bugatti_Veyron_16.4_%E2%80%93_Frontansicht_%281%29%2C_5._April_2012%2C_D%C3%BCsseldorf.jpg"
        }
    }, {
        "identifier": 235,
        "name": "Rubber duck",
        "brand": "Rubber Paradise",
        "original_price": 60,
        "current_price": 1,
        "currency": "EUR",
        "image": {
            "id": 102,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Rubber_duckies_So_many_ducks.jpg/220px-Rubber_duckies_So_many_ducks.jpg"
        }
    }, {
        "identifier": 237,
        "name": "Tasty cucumber",
        "brand": "Veggie World",
        "original_price": 1,
        "current_price": 0.79,
        "currency": "CHF",
        "image": {
            "id": 103,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/ARS_cucumber.jpg/220px-ARS_cucumber.jpg"
        }
    }, {
        "identifier": 239,
        "name": "Toilet with flush water tank",
        "brand": "Plastic Fantastic",
        "original_price": 100,
        "current_price": 20,
        "currency": "USD",
        "image": {
            "id": 104,
            "url": "https://upload.wikimedia.org/wikipedia/commons/0/06/Toilet_with_flush_water_tank.jpg"
        }
    }, {
        "identifier": 242,
        "name": "Ceramic vessel",
        "brand": "Siemens",
        "original_price": 200,
        "current_price": 200,
        "currency": "PLN",
        "image": {
            "id": 107,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/20140707_Radkersburg_-_Large_ceramic_vessel_%28Gombosz_collection%29_-_H4225.jpg/240px-20140707_Radkersburg_-_Large_ceramic_vessel_%28Gombosz_collection%29_-_H4225.jpg"
        }
    }, {
        "identifier": 243,
        "name": "Ferrari 550",
        "brand": "Ferrari",
        "original_price": 1000000,
        "current_price": 50000,
        "currency": "USD",
        "image": {
            "id": 108,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Ferrari_550_maranello_vue_avant.jpg/240px-Ferrari_550_maranello_vue_avant.jpg"
        }
    }, {
        "identifier": 244,
        "name": "Kebab",
        "brand": "Mustafa",
        "original_price": 3,
        "current_price": 3,
        "currency": "EUR",
        "image": {
            "id": 109,
            "url": "https://upload.wikimedia.org/wikipedia/commons/b/b3/Kebab_Bakhtyari.jpg"
        }
    }, {
        "identifier": 245,
        "name": "Grass seeds",
        "brand": "Farmer Bob",
        "original_price": 10,
        "current_price": 5,
        "currency": "USD",
        "image": {
            "id": 789,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/AllenParkSeeds.JPG/240px-AllenParkSeeds.JPG"
        }
    },
    {
        "identifier": 246,
        "name": "Hands on mobile",
        "brand": "Hands on",
        "original_price": 12398,
        "current_price": 3829,
        "currency": "EUR",
        "image": {
            "id": 110,
            "url": "https://upload.wikimedia.org/wikipedia/commons/2/28/Samsung-Galaxy-S8-Test-Hands-On-7-1024x769.jpg"
        }
    }, {
        "identifier": 247,
        "name": "Talking Fish",
        "brand": "Fisher-Price",
        "original_price": 12,
        "current_price": 12,
        "currency": "EUR",
        "image": {
            "id": 111,
            "url": "https://upload.wikimedia.org/wikipedia/commons/6/6e/Redear_sunfish_FWS_1.jpg"
        }
    }, {
        "identifier": 248,
        "name": "Ice Tea",
        "brand": "Tea-Land",
        "original_price": 1,
        "current_price": 0.79,
        "currency": "CHF",
        "image": {
            "id": 112,
            "url": "https://upload.wikimedia.org/wikipedia/commons/a/a0/Ice_Tea_peach.jpg"
        }
    }, {
        "identifier": 250,
        "name": "Turbine blade on a steam turbine rotor",
        "brand": "Siemens",
        "original_price": 100000,
        "current_price": 20000,
        "currency": "USD",
        "image": {
            "id": 114,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Dampfturbine_Laeufer01.jpg/1024px-Dampfturbine_Laeufer01.jpg"
        }
    }, {
        "identifier": 251,
        "name": "Spoon",
        "brand": "Generic",
        "original_price": 2,
        "current_price": 1,
        "currency": "CHF",
        "image": {
            "id": 115,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Soup_Spoon.jpg/240px-Soup_Spoon.jpg"
        }
    }, {
        "identifier": 253,
        "name": "Ferrari 780 Booster",
        "brand": "Ferrari",
        "original_price": 2000000,
        "current_price": 80000,
        "currency": "USD",
        "image": {
            "id": 117,
            "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Ferrari_430_Scuderia_Spider.JPG/1200px-Ferrari_430_Scuderia_Spider.JPG"
        }
    }, {
        "identifier": 254,
        "name": "Vegetarian Kebab",
        "brand": "Kathy",
        "original_price": 3,
        "current_price": 3,
        "currency": "EUR",
        "image": {
            "id": 118,
            "url": "https://upload.wikimedia.org/wikipedia/commons/6/69/Zwei_Doener_Kebab.JPG"
        }
    }, {
        "identifier": 255,
        "name": "Plastic seeds",
        "brand": "Farmer Rolf",
        "original_price": 10,
        "current_price": 5,
        "currency": "USD",
        "image": {
            "id": 119,
            "url": "https://upload.wikimedia.org/wikipedia/commons/1/13/Plastic_beach_-_geograph.org.uk_-_798994.jpg"
        }
    }
    ]
}
"""
