(function () {
  class Commands {
    static ClientId = 3;
    static GetNewClientGuid = 3;
    static SetOldClientGuid = 4;
  }

  class WsService {
    static wsUrlOld = 'wss://uno-game.ddns.com:7192/ws';
    static wsUrlOld2 = 'ws://192.168.0.101:7192/ws';
    static wsUrlOld3 = 'ws://192.168.0.144:7192/ws';
    static wsUrl = 'ws://192.168.56.103:7192/ws';
    ws;
    constructor(onOpenCallback) {
      this.ws = new WebSocket(WsService.wsUrl);
      this.ws.binaryType = 'arraybuffer';
      if (onOpenCallback) {
        this.ws.onopen = onOpenCallback;
      }
    }

    get webSocket() {
      return this.ws;
    }

    reconenctIfClosed() {
      if (this.ws.CLOSED || this.ws.CLOSING) {
        console.log(`TRYING TO RECONECT = ${this.ws.readyState}`);
        this.ws = new WebSocket(WsService.wsUrl);
        this.ws.binaryType = 'arraybuffer';
      }
    }

    isValid() {
      return (
        this.ws.readyState != this.ws.CLOSED &&
        this.ws.readyState != this.ws.CLOSING
      );
    }

    send(arrayBuffer) {
      // this.reconenctIfClosed();
      if (!this.isValid()) {
        console.log(`INVALID CONNECTION readyState = ${this.ws.readyState}`);
      }
      this.ws.send(arrayBuffer);
    }

    setOnMessage(callback) {
      this.ws.onmessage = callback;
      console.log(`SUCCESSFULY SET CALLBACK ON MESSAGE`);
      console.log(`WEBSOCKET BinaryType IS ${this.ws.binaryType}`);
    }
  }

  window.clientId;

  window.ws = new WsService(() => {
    window.clientId = new ClientID();
  });
  window.ws.setOnMessage((message) => {
    if (globalThis.wsOnMessage) {
      globalThis.wsOnMessage(message.data);
    }
  });

  const onMessageClientIdEventHandler = (event) => {
    const message = new Uint8Array(event.data);
    if (message[0] == Commands.ClientId) {
      console.log(`RECIEVED CLIEND ID MESSAGE`);
      window.clientId.clientId = new Uint8Array(message.slice(1));
      window.clientId.initClientIdToHexString();
      console.log(`CLIEND ID ::: ${window.clientId.clientIdHexString}`);
      window.clientId.removeListener();
      window.localStorage.setItem(
        ClientID.ClientIDKeyName,
        window.clientId.clientIdHexString
      );
    }
  };

  class ClientID {
    static ClientIDKeyName = 'ClientID';
    clientId;
    clientIdHexString = '';

    get clientIdHexString() {
      return this.clientIdHexString;
    }

    get clientId() {
      return this.clientId;
    }

    set clientId(arrayBuffer) {
      this.clientId = arrayBuffer;
    }

    constructor() {
      let key = window.localStorage.getItem(ClientID.ClientIDKeyName);
      if (key != null) {
        this.#setClientIdFromHexString(key);
        this.initClientIdToHexString();
        console.log(`FOUND KEY ::: ${this.clientIdHexString}`);
        this.#sendSetOldClientGuidCommand();
      } else {
        this.#sendGetNewClientGuidCommand();
      }
    }

    #sendGetNewClientGuidCommand() {
      window.ws.webSocket.addEventListener(
        'message',
        onMessageClientIdEventHandler
      );
      let arrayToSend = new Uint8Array(8);
      arrayToSend[0] = Commands.ClientId;
      arrayToSend[1] = Commands.GetNewClientGuid;
      console.log(
        `SENDING GET NEW KEY MSG ${arrayToSend
          .map((e) => parseInt(e))
          .join(' ')}`
      );
      window.ws.send(arrayToSend);
    }

    #sendSetOldClientGuidCommand() {
      let arrayToSend = new Uint8Array(18);
      arrayToSend[0] = Commands.ClientId;
      arrayToSend[1] = Commands.SetOldClientGuid;
      arrayToSend.set(this.clientId, 2);
      window.ws.send(arrayToSend);
    }

    removeListener() {
      window.ws.webSocket.removeEventListener(
        'message',
        onMessageClientIdEventHandler
      );
    }

    initClientIdToHexString() {
      this.clientIdHexString = '';
      for (let i = 0; i < 16; i++) {
        this.clientIdHexString += this.clientId[i]
          .toString(16)
          .padStart(2, '0');
        if (i == 3 || i == 5 || i == 7 || i == 9) {
          this.clientIdHexString += '-';
        }
      }
    }

    #setClientIdFromHexString(clientIdHexString) {
      let inputString = clientIdHexString.replaceAll('-', '');
      let outputArrayBuffer = new Uint8Array(16);
      for (let i = 0; i < 16; i++) {
        const firstIndex = i + i;
        const secondIndex = firstIndex + 2;
        outputArrayBuffer[i] = this.#hexToByte(
          inputString.slice(firstIndex, secondIndex)
        );
      }
      this.clientId = outputArrayBuffer;
    }

    #hexToByte(hexString) {
      const byteValue = parseInt(hexString, 16);
      if (isNaN(byteValue) || byteValue < 0 || byteValue > 255) {
        throw new Error(`Invalid hexadecimal conversion at input ${hexString}`);
      }
      return byteValue;
    }
  }
})();
