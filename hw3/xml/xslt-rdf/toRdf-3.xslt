<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex="http://example.org/vocabulary/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:dbo="https://dbpedia.org/ontology/"
                xmlns:schema="https://schema.org/"
                xmlns:teams="http://example.org/teams/"
                xmlns:games="http://example.org/games/"
                xmlns:leagues="http://example.org/leagues/"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema#">
    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>

    <!-- Root template -->
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
        <xsl:apply-templates select="sportsEvent"/>
    </xsl:template>

    <!-- Template for each SportsEvent -->
    <xsl:template match="sportsEvent">
        <xsl:variable name="gameId" select="concat('games:g', position())"/>
        <xsl:variable name="startDate" select="startDate"/>
        <xsl:variable name="score" select="score"/>
        <xsl:variable name="league" select="gamesInLeague/label"/>
        <xsl:variable name="prize" select="gamesInLeague/prize"/>
        <xsl:variable name="season" select="gamesInLeague/currentSeason"/>
        <xsl:variable name="homeTeam" select="homeTeam/label"/>
        <xsl:variable name="awayTeam" select="awayTeam/label"/>
        <xsl:variable name="homeTeamValue" select="homeTeam/teamValue"/>
        <xsl:variable name="awayTeamValue" select="awayTeam/teamValue"/>

        <!-- RDF for SportsEvent -->
        <xsl:value-of select="$gameId"/>
        <xsl:text> a schema:SportsEvent ;&#xa;</xsl:text>
        <xsl:text>    schema:startDate "</xsl:text>
        <xsl:value-of select="$startDate"/>
        <xsl:text>"^^xsd:dateTime ;&#xa;</xsl:text>
        <xsl:text>    ex:score "</xsl:text>
        <xsl:value-of select="$score"/>
        <xsl:text>"@en ;&#xa;</xsl:text>
        <xsl:text>    schema:awayTeam teams:</xsl:text>
        <xsl:value-of select="$awayTeam"/>
        <xsl:text> ;&#xa;</xsl:text>
        <xsl:text>    schema:homeTeam teams:</xsl:text>
        <xsl:value-of select="$homeTeam"/>
        <xsl:text> .&#xa;&#xa;</xsl:text>

        <!-- RDF for League -->
        <xsl:text>leagues:</xsl:text>
        <xsl:value-of select="$league"/>
        <xsl:text> a dbo:SportsLeague ;&#xa;</xsl:text>
        <xsl:text>    ex:prize </xsl:text>
        <xsl:value-of select="$prize"/>
        <xsl:text> ;&#xa;</xsl:text>
        <xsl:text>    dbo:currentSeason "</xsl:text>
        <xsl:value-of select="$season"/>
        <xsl:text>"@en .&#xa;&#xa;</xsl:text>

        <!-- RDF for Teams -->
        <xsl:for-each select="homeTeam | awayTeam">
            <xsl:variable name="teamLabel" select="label"/>
            <xsl:variable name="teamValue" select="teamValue"/>
            <xsl:text>teams:</xsl:text>
            <xsl:value-of select="$teamLabel"/>
            <xsl:text> a dbo:SportsTeam ;&#xa;</xsl:text>
            <xsl:text>    rdfs:label "</xsl:text>
            <xsl:value-of select="$teamLabel"/>
            <xsl:text>"@en ;&#xa;</xsl:text>
            <xsl:text>    ex:teamValue </xsl:text>
            <xsl:value-of select="$teamValue"/>
            <xsl:text> .&#xa;&#xa;</xsl:text>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
