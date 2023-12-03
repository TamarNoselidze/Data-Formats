<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xml="http://www.w3.org/XML/1998/namespace">

    <!-- Root template -->
    <xsl:template match="/root">
        <html>
            <head>
                <title>Sports Teams</title>
            </head>
            <body>
                <h1>Sports Teams Information</h1>
                <xsl:apply-templates select="sportsTeam">
                    <xsl:sort select="label"/>
                </xsl:apply-templates>
            </body>
        </html>
    </xsl:template>

    <!-- Template for each sportsTeam -->
    <xsl:template match="sportsTeam">
        <div>
            <h2>Team: <xsl:value-of select="label"/></h2>
            <p>Team Value: <xsl:value-of select="teamValue"/></p>
            
            <xsl:if test="count(teamsInLeague) > 0">
                <h3>Team is in Leagues:</h3>
                <xsl:apply-templates select="teamsInLeague"/>
            </xsl:if>
            
            <xsl:if test="count(leagueWinner) > 0">
                <h3>Won Leagues:</h3>
                <xsl:apply-templates select="leagueWinner"/>
            </xsl:if>

            <h3>Players in Team:</h3>
            <xsl:apply-templates select="playerInTeam | leadTeam">
                <xsl:sort select="jerseyNumber" data-type="number"/>
            </xsl:apply-templates>
        </div>
    </xsl:template>

    <!-- Template for teamsInLeague and leagueWinner -->
    <xsl:template match="teamsInLeague | leagueWinner">
        <div>
            <span>League: <xsl:value-of select="label"/></span>,
            <span>Prize: <xsl:value-of select="prize"/></span>,
            <span>Season: <xsl:value-of select="currentSeason"/></span>
        </div>
    </xsl:template>

    <!-- Template for playerInTeam and leadTeam -->
    <xsl:template match="playerInTeam | leadTeam">
        <p>Jersey Number: <xsl:value-of select="jerseyNumber"/></p>
    </xsl:template>

</xsl:stylesheet>
