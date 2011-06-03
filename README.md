[SOS max](http://www.sos.powerflasher.com/) is a socket server, that provides a graphical interface for outputting debugging messages from Flash. It's sort of a much more advanced trace() function, that helps when you don't have access to the data trace() outputs. However, since SOS max is connected to through XMLSocket, it's a bit more work to set up than trace(). SOSConnection helps with that. It handles the set up of the connection, and provides many helper functions so you can just plainly trace out your data, and not worry about mixing different XML nodes. Let's have a look at a quick example:

# Quick Example

**Normal Code**

``` actionscript3
var sos:XMLSocket = new XMLSocket("localhost", 4444);
sos.addEventListener(Event.CONNECT, onConnect);

function onConnect(event:Event):void
{
    sos.send("!SOS<showMessage key='trace'>This is my trace styled message!</showMessage>\n");
    sos.send("!SOS<setKey><name>custom</name><color>" + 0xff00ff + "</color></setKey>\n");
    sos.send("!SOS<showFoldMessage key='custom'>" +
             "<title>Folded Message</title>" +
             "<message>This is my multi-line\nmessage\n...</message>" +
             "</showFoldMessage>\n");
    sos.send("!SOS<clear />\n");
}
```

**Code with SOSConnection**

``` actionscript3
var sos:SOSConnection = new SOSConnection();
sos.addEventListener(Event.CONNECT, onConnect);

function onConnect(event:Event):void
{
    sos.trace("This is my trace styled message!");
    sos.setKey("custom", 0xff00ff);
    sos.sendFoldMessage("Folded Message", "This is my multi-line\nmessage\n...", "custom");
    sos.clear();
}
```

As you can see, SOSConnection deals with all the XML nodes for you, allowing you to focus on what you want to send. And if you really want to send something custom, you can use the send() function.

# Main Features

* Handles setup of connection for you
* Handles XML nodes for you, allowing to focus on what you actually want to send
* Many helpful functions in the class, one for every standard key that comes with SOS max

# Change Log

**Version 1.0.1 - October 22, 2010**

Fixed a rather large design flaw. It was very possible to try and send messages to SOS max before the connection had been made in version 1.0. This is now how you setup your SOSConnection:

``` actionscript3
var sos:SOSConnection = new SOSConnection();
sos.addEventListener(Event.CONNECT, yourConnectListener);
```

**Version 1.0 - August 8, 2010**

Initial release.
