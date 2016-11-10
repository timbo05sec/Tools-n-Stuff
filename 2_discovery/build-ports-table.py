#!/usr/bin/env python

import xml.etree.ElementTree as nmapElementTree
import sys
import os.path

def checkArgs(nmapArgs):
    if len(nmapArgs) != 2:
        print('This script takes one argument, the path to an nmap xml file.')
        sys.exit()
    else:
        return True

def nmapParse(nmapFile):
    if not os.path.isfile(nmapFile):
        print('File not found.  Invalid path specified')
        sys.exit()
    try:
        nmapTree = nmapElementTree.parse(nmapFile)
        nmapRoot = nmapTree.getroot()
    except nmapElementTree.ParseError as e:
        print(str(e))
        sys.exit()
    for nmapHost in nmapRoot.findall('host'):
        outPort = ""
        outService = ""
        nmapAddress = nmapHost.find('address').get('addr', "")
        nmapPorts = nmapHost.find('ports')
        for nmapPort in nmapPorts.findall('port'):
            nmapState = nmapPort.find('state').get('state', "")
            if nmapState == 'open':
                outPort = outPort+nmapPort.get('portid')+'/'+nmapPort.get('protocol')+';'
                if not nmapPort.find('service') == None:
                    nmapServiceName = nmapPort.find('service').get('name', "")
                    nmapServiceProduct = nmapPort.find('service').get('product', "")
                    nmapServiceVersion = nmapPort.find('service').get('version', "")
                    outService = outService+nmapServiceName+' '+nmapServiceProduct+' '+nmapServiceVersion+';'
                else:
                    outService = outService+' ;'
        print(nmapAddress+',,'+outPort.rstrip(';')+','+outService.rstrip(';'))

if checkArgs(sys.argv):
    nmapParse(sys.argv[1])
