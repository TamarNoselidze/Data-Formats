<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:ex="http://example.org/vocabulary/"
  xmlns:dbo="https://dbpedia.org/ontology/"
  xmlns:foaf="http://xmlns.com/foaf/0.1/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:xml="http://www.w3.org/XML/1998/namespace"
  xmlns:teams="http://example.org/teams/"
  xmlns:leagues="http://example.org/leagues/"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
  xmlns:schema="https://schema.org/">

  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>

  <!-- Template for the root element -->
  <xsl:template match="/root">
        <!-- Output the RDF Turtle prefixes and base URI -->
        <xsl:text># @base &lt;http://example.org/&gt; .
@prefix ex: &lt;http://example.org/vocabulary/&gt; .
@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix foaf: &lt;http://xmlns.com/foaf/0.1/&gt; .
@prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
@prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .
@prefix roh: &lt;http://w3id.org/roh/0.3&gt; .
@prefix vivo: &lt;http://vivoweb.org/ontology/core&gt; .
@prefix dbo: &lt;https://dbpedia.org/ontology/&gt; .
@prefix schema: &lt;https://schema.org/&gt; .

@prefix teams: &lt;http://example.org/teams/&gt; .
@prefix games: &lt;http://example.org/games/&gt; .
@prefix leagues: &lt;http://example.org/leagues/&gt; .
</xsl:text>
        <xsl:text>&#xa;</xsl:text>

    <xsl:apply-templates/>
  </xsl:template>

  <!-- Template for sportsTeam -->
  <xsl:template match="sportsTeam">
    <xsl:variable name="teamName" select="normalize-space(label)"/>
    <xsl:text>teams:</xsl:text><xsl:value-of select="$teamName"/>
    <xsl:text> a dbo:SportsTeam ;&#10;</xsl:text>
    <xsl:apply-templates select="label"/>
    <xsl:apply-templates select="teamValue"/>
    <xsl:apply-templates select="teamsInLeague"/>
    <xsl:apply-templates select="leagueWinner"/>
    <xsl:apply-templates select="playerInTeam"/>
    <xsl:apply-templates select="leadTeam"/>
    <xsl:text>.&#10;&#10;</xsl:text>
  </xsl:template>

  <!-- Template for label -->
  <xsl:template match="sportsTeam/label">
    <xsl:text>    rdfs:label "</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>"@en ;&#10;</xsl:text>
  </xsl:template>

  <!-- Template for teamValue -->
  <xsl:template match="sportsTeam/teamValue">
    <xsl:text>    ex:teamValue "</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>"^^xsd:double ;&#10;</xsl:text>
  </xsl:template>

  <!-- Template for teamsInLeague -->
  <xsl:template match="sportsTeam/teamsInLeague">
    <xsl:variable name="leagueName" select="normalize-space(label)"/>
    <xsl:text>    ex:teamsInLeague leagues:</xsl:text>
    <xsl:value-of select="$leagueName"/>
    <xsl:text> ;&#10;</xsl:text>
  </xsl:template>

  <!-- Template for leagueWinner -->
  <xsl:template match="sportsTeam/leagueWinner">
    <xsl:variable name="leagueName" select="normalize-space(label)"/>
    <xsl:text>    ex:leagueWinner leagues:</xsl:text>
    <xsl:value-of select="$leagueName"/>
    <xsl:text> ;&#10;</xsl:text>
  </xsl:template>

  <!-- Template for playerInTeam -->
  <xsl:template match="sportsTeam/playerInTeam">
    <xsl:variable name="playerJerseyNumber" select="jerseyNumber"/>
    <!-- Logic to match playerJerseyNumber to a specific player IRI goes here -->
    <xsl:text>    dbo:playerInTeam ex:Player</xsl:text>
    <xsl:value-of select="$playerJerseyNumber"/>
    <xsl:text> ;&#10;</xsl:text>
  </xsl:template>

  <!-- Template for leadTeam -->
  <xsl:template match="sportsTeam/leadTeam">
    <xsl:variable name="captainJerseyNumber" select="jerseyNumber"/>
    <!-- Logic to match captainJerseyNumber to a specific captain IRI goes here -->
    <xsl:text>    dbo:leadTeam ex:Captain</xsl:text>
    <xsl:value-of select="$captainJerseyNumber"/>
    <xsl:text> ;&#10;</xsl:text>
  </xsl:template>

</xsl:stylesheet>
