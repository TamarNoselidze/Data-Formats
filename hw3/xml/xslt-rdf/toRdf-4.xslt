<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex="http://example.org/vocabulary/"
                xmlns:dbo="https://dbpedia.org/ontology/"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
                exclude-result-prefixes="xsl ex dbo xsd">

    <xsl:output method="text"/>
    <xsl:strip-space elements="*"/>

    <!-- Template for the root element -->
    <xsl:template match="/root">
        <!-- Output the RDF Turtle prefixes and base URI -->
        <xsl:text># @base &lt;http://example.org/&gt; .
@prefix ex: &lt;http://example.org/vocabulary/&gt; .
@prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
@prefix dbo: &lt;https://dbpedia.org/ontology/&gt; .
@prefix teams: &lt;http://example.org/teams/&gt; .
@prefix leagues: &lt;http://example.org/leagues/&gt; .
</xsl:text>
        <xsl:text>&#xa;</xsl:text>

        <!-- Process sports leagues -->
        <xsl:apply-templates select="sportsLeague"/>
    </xsl:template>

    <!-- Template for each sportsLeague -->
    <xsl:template match="sportsLeague">
        <!-- Use league label as the identifier -->
        <xsl:variable name="leagueId" select="concat('leagues:', label)"/>

        <!-- Start RDF description for the league -->
        <xsl:value-of select="$leagueId"/>
        <xsl:text> a dbo:SportsLeague ;</xsl:text>
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>    dbo:prize </xsl:text>
        <xsl:value-of select="prize"/>
        <xsl:text> ;</xsl:text>
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>    dbo:currentSeason "</xsl:text>
        <xsl:value-of select="currentSeason"/>
        <xsl:text>"@en .</xsl:text>
        <xsl:text>&#xa;</xsl:text>

        <!-- Process teams in league -->
        <xsl:apply-templates select="teamsInLeague"/>
        
        <!-- Process league winners -->
        <xsl:apply-templates select="leagueWinner"/>
    </xsl:template>

    <!-- Template for teamsInLeague -->
    <xsl:template match="teamsInLeague">
        <xsl:variable name="teamId" select="concat('teams:', label)"/>

        <!-- RDF description for the team -->
        <xsl:value-of select="$teamId"/>
        <xsl:text> a dbo:SportsTeam ;</xsl:text>
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>    ex:teamValue </xsl:text>
        <xsl:value-of select="teamValue"/>
        <xsl:text> ;</xsl:text>
        <xsl:text>&#xa;</xsl:text>
        <xsl:text>    rdfs:label "</xsl:text>
        <xsl:value-of select="label"/>
        <xsl:text>"@en .</xsl:text>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

    <!-- Template for leagueWinner -->
    <xsl:template match="leagueWinner">
        <xsl:variable name="winnerId" select="concat('teams:', label)"/>

        <!-- RDF description for the league winner -->
        <xsl:text>leagues:</xsl:text>
        <xsl:value-of select="../label"/>
        <xsl:text> ex:leagueWinner </xsl:text>
        <xsl:value-of select="$winnerId"/>
        <xsl:text> .</xsl:text>
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
