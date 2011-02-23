### Version 1.0.1 - October 22, 2010

Fixed a rather large design flaw. It was very possible to try and send messages to SOS max before the connection had been made in version 1.0. This is now how you setup your SOSConnection:

    var sos:SOSConnection = new SOSConnection();  
    sos.addEventListener(Event.CONNECT, yourConnectListener);

### Version 1.0 - August 8, 2010

Initial release.