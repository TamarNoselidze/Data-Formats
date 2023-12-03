import xmltodict
import json

# XML data as a string
xml_data = '''
<root>
    <person>
        <name>John Doe</name>
        <age>30</age>
        <city>New York</city>
    </person>
    <person>
        <name>Jane Smith</name>
        <age>25</age>
        <city>Los Angeles</city>
    </person>
</root>
'''

# Convert XML to a Python dictionary
data_dict = xmltodict.parse(xml_data)

# Convert the dictionary to JSON
json_data = json.dumps(data_dict, indent=2)

# Print the resulting JSON
print(json_data)
