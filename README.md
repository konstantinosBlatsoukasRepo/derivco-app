# App

This app exposes information about previous results per league/season. You can access all the results by an HTTP API, in order to be able to access the results please follow the bellow guide.

## Sections

- [Required software](#required-software)
- [How to start the App](#how-to-start-the-app)

## Required software

- Docker, if not installed click [`here`](https://docs.docker.com/install/)
- docker-compose command, if not installed click [`here`](https://docs.docker.com/v17.09/compose/install/#install-compose)
- git, if not installed click [`here`](https://git-scm.com/downloads)

## How to start the App

- go to the following link [`app code`](https://github.com/konstantinosBlatsoukasRepo/sport-app)
- click on the button `clone or download`
- copy the link
- open a terminal and execute the command `git clone` plus the link that you copied, press enter
- change directory to app (e.g. `cd sport-app`)
- build image app by running (this may take a while):

```shell
  docker build -t derivco-app:1.12 .
```

- finally, start the server by running:

```shell
  docker-compose up
```

## Access HTTP API

Once the app is up and running, you can access see the documentation of the HTTP API by accessing this [`link`](http://localhost:4000/swaggerui)

-> access the all the available league/season pairs, perform an HTTP GET on:

```
http://localhost:4000/api/leauge-season-pairs
```

-> the response should look like this:

```json
{
  "leagueSeasonPairs": [
    {
      "leagueId": "D1",
      "seasonId": "201617"
    },
    {
      "leagueId": "E0",
      "seasonId": "201617"
    },
    {
      "leagueId": "SP1",
      "seasonId": "201516"
    },
    {
      "leagueId": "SP1",
      "seasonId": "201617"
    },
    {
      "leagueId": "SP2",
      "seasonId": "201516"
    },
    {
      "leagueId": "SP2",
      "seasonId": "201617"
    }
  ]
}
```

-> access the all the results for a specific league/season by performing an HTTP GET on:

```
http://localhost:4000/api/leauge-season-pairs/league_id/season_id/results
```

-> the response should look like this:

```json
{
  "results": [
    {
      "awayTeam": "Eibar",
      "date": "19/08/2016",
      "ftAwayGoals": "1",
      "ftHomeGoals": "2",
      "ftResult": "H",
      "homeTeam": "La Coruna",
      "htAwayGoals": "0",
      "htHomeGoals": "0",
      "htResult": "D"
    },
    {
      "awayTeam": "Almeria",
      "date": "20/08/2016",
      "ftAwayGoals": "1",
      "ftHomeGoals": "2",
      "ftResult": "H",
      "homeTeam": "Barcelona",
      "htAwayGoals": "0",
      "htHomeGoals": "0",
      "htResult": "D"
    }
  ]
}
```

Moreover, you can try to call the resources by using the swagger ui

Also, there is a third way to get the results from a specific league/season in a protocol buffer format.

You can do that by performing an HTTP GET on

`localhost:4000/api/proto/leauge-season-pairs/:league_id/:season_id/results`

you have to specify the leuage_id and the season_id, for example :

`/proto/leauge-season-pairs/E0/201617/results`

for deserializing the response the following specification must be compiled:

```
    message LeagueSeasonPair {
      required string awayTeam = 1;
      required string date = 2;
      required string ftAwayGoals = 3;
      required string ftHomeGoals = 4;
      required string ftResult = 5;
      required string homeTeam = 6;
      required string htAwayGoals = 7;
      required string htHomeGoals = 8;
      required string htResult = 9;
    }

    message Response {
      repeated LeagueSeasonPair leagueSeasonPairs = 1;
    }
```
