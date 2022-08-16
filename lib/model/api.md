### Status repas acheté par un ticket
GET /v2api/commands/CM1324A/meals-status
{
    "breakfast": {
        "hasMer": true,
        "hasJeu": true,
        "hasVen": false,
        "hasSam": false,
        "hasDim": false
    },
    "lunch": {
        "hasMer": true,
        "hasJeu": true,
        "hasVen": false,
        "hasSam": false,
        "hasDim": false
    },
    "dinner": {
        "hasMer": false,
        "hasJeu": false,
        "hasVen": false,
        "hasSam": false,
        "hasDim": false
    }
}
### Consummer un repas 
/v2api/commands/CM1324A/consume/mer/breakfast
200
{
    "status" : "OK"
}

400
{
    "status": "KO",
    "code_error": "CONSUMED",
    "message": "Already consumed!"
}
400
{
    "status": "KO",
    "code_error": "INVALID",
    "message": "Invalid command options \"CM1324A\" - \"mers\" - \"breakfast\""
}

## TODO

### Verification info badge
GET /v2api/badges/{number}

{
	"number" : "...",
	"firstname" : "...",
    "lastname" : "...",
    "name" : "...",
    "image" : "...",
    "churchName" : "..."
}

Liste an'ireo repas activé

GET /v2api/meal/enabled

[
    {
        "day": "MER",
        "mealType" : "BREAKFAST"
    },
    {
        "day": "MER",
        "mealType" : "LUNCH"
    }
]