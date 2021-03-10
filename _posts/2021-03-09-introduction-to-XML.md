---
tags:
    - stat196k
---

- extract data from XML documents

XML stands for eXtensible Markup Language.

## Announcements

123 GO:


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

# XML vocabulary


# XML represents data in a hierarchical format {.t}

Draw tree of document


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


# If we didn't know XML, how might we find and extract the tag `CityNm`?


```julia
using EzXML

doc = readxml("201932259349302043_public.xml")

findall("//BusinessNameLine1Txt", doc)
```


