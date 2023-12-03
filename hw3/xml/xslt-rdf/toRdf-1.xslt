<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ex="http://example.org/vocabulary/"
                xmlns:foaf="http://xmlns.com/foaf/0.1/"
                xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
                xmlns:dbo="https://dbpedia.org/ontology/"
                xmlns:roh="http://w3id.org/roh/0.3"
                xmlns:vivo="http://vivoweb.org/ontology/core"
                exclude-result-prefixes="xsl ex foaf xsd dbo roh vivo">

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

        <!-- Process child elements -->
        <xsl:apply-templates/>
    </xsl:template>

    <!-- Template for each person -->
    <xsl:template match="/root/person">
        <!-- Use first name as the identifier -->
        <xsl:variable name="personId" select="concat('ex:', firstName)"/>

        <!-- Start RDF description -->
        <xsl:value-of select="$personId"/>
        <xsl:text> a dbo:Athlete ;</xsl:text>
        <xsl:text>&#xa;</xsl:text>

        <!-- Handle Captain -->
        <xsl:if test="athlete/captain">
            <xsl:text>    a ex:Captain ;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>

        <!-- Jersey Number -->
        <xsl:if test="athlete/jerseyNumber">
            <xsl:text>    ex:jerseyNumber </xsl:text>
            <xsl:value-of select="athlete/jerseyNumber"/>
            <xsl:text> ;</xsl:text>
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>

        <!-- Names and Birthdate -->
        <xsl:text>    foaf:firstName "</xsl:text>
        <xsl:value-of select="firstName"/>
        <xsl:text>"@en ;</xsl:text>
        <xsl:text>&#xa;</xsl:text>

        <xsl:text>    foaf:surname "</xsl:text>
        <xsl:value-of select="surname"/>
        <xsl:text>"@en ;</xsl:text>
        <xsl:text>&#xa;</xsl:text>

        <!-- Adjust birthDate format to match data.ttl -->
        <xsl:if test="birthDate">
            <xsl:text>    roh:birthDate "</xsl:text>
            <xsl:value-of select="substring-before(birthDate, 'Z')"/>
            <xsl:text>"^^xsd:dateTime .</xsl:text>
            <xsl:text>&#xa;</xsl:text>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
