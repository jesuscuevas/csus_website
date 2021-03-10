---
date: 2021-03-10
tags:
    - stat196k
---

- describe XML data model
- extract data from XML documents using XPath

XML stands for eXtensible Markup Language.

## Announcements

- Plan to go over next homework assignment for next class
- STAT 128 in Fall 2021: virtual or hybrid?

123 GO: Would you rather do virtual or hybrid for a class like this in Fall?


## References

- [XPath Syntax](https://www.w3schools.com/xml/xpath_syntax.asp) by W3 schools


# Why should we learn how to extract data from XML?

Or why learn any other data format, for that matter?

```XML
    <Filer>
      <EIN>042888848</EIN>
      <BusinessName>
        <BusinessNameLine1Txt>FREE SOFTWARE FOUNDATION INC</BusinessNameLine1Txt>
      </BusinessName>
      <BusinessNameControlTxt>FREE</BusinessNameControlTxt>
      <PhoneNum>6175425942</PhoneNum>
      <USAddress>
        <AddressLine1Txt>51 FRANKLIN STREET SUITE 500</AddressLine1Txt>
        <CityNm>BOSTON</CityNm>
        <StateAbbreviationCd>MA</StateAbbreviationCd>
        <ZIPCd>02110</ZIPCd>
      </USAddress>
    </Filer>
```

terms: document, opening and closing tags


# XML represents data in a tree like, hierarchical format {.t}

Draw tree of document, nodes, element and text nodes


# Many other data formats can represent hierarchical data

```JSON
{
   "EIN": "042888848",
   "BusinessName": {
      "BusinessNameLine1Txt": "FREE SOFTWARE FOUNDATION INC"
   },
   "BusinessNameControlTxt": "FREE",
   "PhoneNum": "6175425942",
   "USAddress": {
      "AddressLine1Txt": "51 FRANKLIN STREET SUITE 500",
      "CityNm": "BOSTON",
      "StateAbbreviationCd": "MA",
      "ZIPCd": "02110"
   }
}
```

123 GO- JSON stands for Javascript Object Notation. Why?


# If we didn't know XML, how might we find and extract `BOSTON` from inside `CityNm`?

```XML
    <Filer>
      <EIN>042888848</EIN>
      <BusinessName>
        <BusinessNameLine1Txt>FREE SOFTWARE FOUNDATION INC</BusinessNameLine1Txt>
      </BusinessName>
      <BusinessNameControlTxt>FREE</BusinessNameControlTxt>
      <PhoneNum>6175425942</PhoneNum>
      <USAddress>
        <AddressLine1Txt>51 FRANKLIN STREET SUITE 500</AddressLine1Txt>
--->    <CityNm>BOSTON</CityNm>
        <StateAbbreviationCd>MA</StateAbbreviationCd>
        <ZIPCd>02110</ZIPCd>
      </USAddress>
    </Filer>
```

We know command line tools...


# If your data contains structure, then use it.

DON'T do this:

```bash
$ grep "CityNm" 201932259349302043_public.xml

        <CityNm>SOUTHBORO</CityNm>
        <CityNm>BOSTON</CityNm>
        <CityNm>BOSTON</CityNm>
          <CityNm>BOSTON</CityNm>
```

We might be tempted to ignore all the XML structure and just treat the data as text.
This is fine for familiarizing yourself with the data, but BAD for just about anything else.

Why bad?


# We actually wanted `CityNm` under the `Filer` node.


```XML
->  <Filer>
      <EIN>042888848</EIN>
      <BusinessName>
        <BusinessNameLine1Txt>FREE SOFTWARE FOUNDATION INC</BusinessNameLine1Txt>
      </BusinessName>
      <BusinessNameControlTxt>FREE</BusinessNameControlTxt>
      <PhoneNum>6175425942</PhoneNum>
      <USAddress>
        <AddressLine1Txt>51 FRANKLIN STREET SUITE 500</AddressLine1Txt>
--->    <CityNm>BOSTON</CityNm>
        <StateAbbreviationCd>MA</StateAbbreviationCd>
        <ZIPCd>02110</ZIPCd>
      </USAddress>
    </Filer>
```

Devil's advocate: just write a more complicated version of `grep`, right?


# XPath identifies and navigates nodes in an XML document.

```bash
$ xmllint --xpath "//Filer//CityNm/text()" \
    201932259349302043_public.xml 

BOSTON
```

Let's break this command down.


# In data analysis, XPath expressions usually contain `//`.

With `//`:

```bash
$ xmllint --xpath "//Filer//CityNm/text()" \
    201932259349302043_public.xml 

BOSTON
```

Alternatively, with an absolute (full) path:

```bash
$ xmllint --xpath \
    "/Return/ReturnHeader/Filer/USAddress/CityNm/text()" \
    201932259349302043_.xmlic.

BOSTON
```

Suppose we slightly change the structure of the document, say `ReturnHeader` becomes `Header`.

123 GO: Will the absolute path still find `BOSTON`?


# `grep` is a general purpose tool and XPath is a specific tool {.t}

hammer and drill analogy


# Programming languages have packages to process XML using XPath.

For example, with Julia:

```julia
using EzXML

doc = readxml("201932259349302043_public.xml")

city_names = findall("//CityNm", doc)

#  4-element Array{EzXML.Node,1}:
#   EzXML.Node(<ELEMENT_NODE[CityNm]@0x00007ffe8993d9c0>)
#   EzXML.Node(<ELEMENT_NODE[CityNm]@0x00007ffe899549c0>)
#   EzXML.Node(<ELEMENT_NODE[CityNm]@0x00007ffe899314c0>)
#   EzXML.Node(<ELEMENT_NODE[CityNm]@0x00007ffe89999bd0>)
```

123 GO - is it better to learn and use XPath, or something programming language specific?


# An example of querying the document from julia.

```julia
nodecontent(city_names[1])

#  "SOUTHBORO"

[nodecontent(n) for n in city_names]

#  4-element Array{String,1}:
#   "SOUTHBORO"
#   "BOSTON"
#   "BOSTON"
#   "BOSTON"
```


# Using our xpath above:

```julia
fc = findall("//Filer//CityNm/text()", doc)

#   1-element Array{EzXML.Node,1}:
#    EzXML.Node(<TEXT_NODE@0x00007ffe89954a40>)

nodecontent(fc[1])

#   "BOSTON"
```
