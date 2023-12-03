import xmltodict
import json
import sys

f = open('output.txt','w')
sys.stdout = f


# XML data as a string
xml_data = '''
<root xmlns:xml="http://www.w3.org/XML/1998/namespace">
  <!-- Instance 1: SportsLeague NBA -->
  <sportsLeague>
    <label xml:lang="en">nba</label>
    <prize xml:lang="en">3000</prize>
    <currentSeason xml:lang="en">summer</currentSeason>
    <teamsInLeague>
      <label xml:lang="en">Lakers</label>
      <teamValue>2934.8</teamValue>
    </teamsInLeague>
    <teamsInLeague>
      <label xml:lang="en">Knicks</label>
      <teamValue>9214.947</teamValue>
    </teamsInLeague>
        <teamsInLeague>
      <label xml:lang="en">Bulls</label>
      <teamValue>7528.99</teamValue>
    </teamsInLeague>
    <leagueWinner>
      <label xml:lang="en">Knicks</label>
      <teamValue>9214.947</teamValue>
    </leagueWinner>
  </sportsLeague>

  <!-- Instance 2: SportsLeague WNBA -->
  <sportsLeague>
    <label xml:lang="en">wnba</label>
    <prize>6000</prize>
    <currentSeason xml:lang="en">summer</currentSeason>
    <teamsInLeague>
      <label xml:lang="en">Lakers</label>
      <teamValue>2934.8</teamValue>
    </teamsInLeague>
    <teamsInLeague>
      <label xml:lang="en">Bulls</label>
      <teamValue>7528.99</teamValue>
    </teamsInLeague>
    <leagueWinner>
      <label xml:lang="en">Lakers</label>
      <teamValue>2934.8</teamValue>
    </leagueWinner>
  </sportsLeague>

  <!-- Instance 3: SportsLeague FIBA -->
  <sportsLeague>
    <label xml:lang="en">fiba</label>
    <prize>500</prize>
    <currentSeason xml:lang="en">winter</currentSeason>
    <teamsInLeague>
      <label xml:lang="en">Lakers</label>
      <teamValue>2934.8</teamValue>
    </teamsInLeague>
    <leagueWinner>
      <label xml:lang="en">Lakers</label>
      <teamValue>2934.8</teamValue>
    </leagueWinner>
  </sportsLeague>
</root>

'''

# Convert XML to a Python dictionary
data_dict = xmltodict.parse(xml_data)

# Convert the dictionary to JSON
json_data = json.dumps(data_dict, indent=2)

# Print the resulting JSON
print(json_data)
