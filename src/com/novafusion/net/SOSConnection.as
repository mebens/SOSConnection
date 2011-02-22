/**
 * Package information:
 * Contains all the classes related to networking.
 * 
 * Library information:
 * The NovaFusion AS3 library is licensed under the 
 * Simplified BSD License. See LICENSE.txt.
 *
 * GitHub repository currently located at
 * http://github.com/BlackBulletIV/NovaFusion-AS3-Library
 * Visit repository for the latest source code.
 *
 * Made by NovaFusion (www.nova-fusion.com)
 */
package com.novafusion.net
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.XMLSocket;
    
    /**
     * A class to help you use SOS max for your tracing quicker.
     * This class has a number of methods that use predefined
     * message keys in SOS max. There are also methods to set
     * your own keys, send folded messages and so on.
     * 
     * @author  NovaFusion
     * @version 1.0.1
     */
    public class SOSConnection extends EventDispatcher
    {
        /**
         * Whether or not we are currently connected to to SOS max.
         * @since 1.0.1
         */
        public var connected:Boolean = false;
        
        private var _socket:XMLSocket = new XMLSocket();
        
        /**
         * Sets up the connection.
         * @param host The server on which SOS max is located (usually localhost, the default)
         * @param port The port on which the SOS max is listening (by default it's 4444)
         */
        public function SOSConnection(host:String = "localhost", port:uint = 4444)
        {
            _socket.addEventListener(Event.CONNECT, onConnect); // adding an event listener...
            _socket.connect(host, port); // ...and then connecting is important. Because users may try to send stuff before we've connected
        }
        
        //------ CONNECT LISTENER ------//
        
        /**
         * @since 1.0.1
         */ 
        private function onConnect(event:Event):void
        {
            connected = true;
            dispatchEvent(event); // simply refire the same event
        }
        
        //------ PRIMARY FUNCTIONS ------//
        
        /**
         * Sends whatever text you want to SOS max. Don't add a
         * "\n" character on the end, as the function does this 
         * for you.
         * 
         * @param xml The XML (or text) data to send
         */
        public function send(xml:String):void
        {
            _socket.send(xml + "\n");
        }
        
        /**
         * Uses the showMessage node to send a message to send
         * a message to SOS max.
         * 
         * @param   message     The message to send
         * @param   key         The key to style the message in
         */
        public function sendMessage(message:String, key:String = "trace"):void
        {
            _socket.send("!SOS<showMessage key='" + key + "'>" + message + "</showMessage>\n");
        }
        
        /**
         * Uses the showFoldMessage node to send a folded
         * message to SOS max.
         * 
         * @param   title   The title of the folded message
         * @param   message The message to send (can be multi-line)
         * @param   key     The key to style the folded message in
         */
        public function sendFoldMessage(title:String, message:String, key:String = "trace"):void
        {
            _socket.send(
                "!SOS<showFoldMessage key='" + key + "'>" +
                "<title>" + title + "</title>" +
                "<message>" + message + "</message>" +
                "</showFoldMessage>"
            );
        }
        
        /**
         * Uses the setKey node to set a custom key in SOS
         * max. If you plan to use the key you set, make
         * sure that your SOS max server is not blocking
         * the setKey command.
         * 
         * @param name  The name of the key
         * @param color The color of the key
         */
        public function setKey(name:String, color:int):void
        {
            _socket.send("!SOS<setKey><name>" + name + "</name><color>" + color + "</color></setKey>");
        }
        
        /**
         * Sends the clear command to SOS max. Which clears the screen.
         */
        public function clear():void
        {
            _socket.send("!SOS<clear />\n");
        }

        //------ DEFAULT KEY FUNCTIONS ------//
        //----   In order of severity  ------//

        /**
         * Sends a message with the <code>finest</code> key.
         * @param message The text data to send
         */
        public function finest(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='finest'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>finer</code> key.
         * @param message The text data to send
         */
        public function finer(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='finer'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>temp</code> key.
         * @param message The text data to send
         */
        public function temp(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='temp'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>trace</code> key.
         * @param message The text data to send
         */
        public function trace(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='trace'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>config</code> key.
         * @param message The text data to send
         */
        public function config(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='config'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>debug</code> key.
         * @param message The text data to send
         */
        public function debug(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='debug'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>fine</code> key.
         * @param message The text data to send
         */
        public function fine(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='fine'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>info</code> key.
         * @param message The text data to send
         */
        public function info(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='info'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>warning</code> key.
         * @param message The text data to send
         */
        public function warning(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='warning'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>warn</code> key.
         * @param message The text data to send
         */
        public function warn(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='warn'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>severe</code> key.
         * @param message The text data to send
         */
        public function severe(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='severe'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>error</code> key.
         * @param message The text data to send
         */
        public function error(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='error'>" + message + "</showMessage>\n");
        }
        
        /**
         * Sends a message with the <code>fatal</code> key.
         * @param message The text data to send
         */
        public function fatal(message:String = ""):void
        {
            _socket.send("!SOS<showMessage key='fatal'>" + message + "</showMessage>\n");
        }
    }
}