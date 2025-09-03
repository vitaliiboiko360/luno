(function () {
  class Commands {
    static ClientId = 3;
    static GetNewClientGuid = 3;
    static SetOldClientGuid = 4;
  }

  class WsService {
    static wsUrl = 'wss://uno-game.ddns.com:7192/ws';
    ws;
    constructor(onOpenCallback) {
      this.ws = new WebSocket(WsService.wsUrl);
      this.ws.binaryType = 'arraybuffer';
      if (onOpenCallback) {
        this.ws.onopen = onOpenCallback;
      }
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
      if (this.isValid()) {
        console.log(`readyState = ${this.ws.readyState}`);
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

  class ClientID {
    static ClientIDKeyName = 'ClientID';
    clientId;
    clientIdHexString = '';
    constructor() {
      let key = window.localStorage.getItem(ClientIDKeyName);
      if (key != null) {
        this.#getClientIdFromHexString(key);
        this.#getClientIdToHexString();
        console.log(`FOUND KEY ::: ${this.clientIdHexString}`);
        this.#sendSetOldClientGuidCommand();
      } else {
        this.#sendGetNewClientGuidCommand();
      }
    }

    #sendGetNewClientGuidCommand() {
      window.ws.addEventListener(
        'message',
        this.#onMessageClientIdEventHandler
      );
      let arrayToSend = new ArrayBuffer(8);
      arrayToSend[0] = Commands.ClientId;
      arrayToSend[1] = Commands.GetNewClientGuid;
      window.ws.send(arrayToSend);
    }

    #sendSetOldClientGuidCommand() {
      window.ws.send(this.clientId);
    }

    #removeListener() {
      window.ws.removeEventHandler(
        'message',
        this.#onMessageClientIdEventHandler
      );
    }

    #onMessageClientIdEventHandler(event) {
      const message = event.data;
      if (message[0] == Commands.ClientId) {
        console.log(`RECIEVED CLIEND ID MESSAGE`);
        this.clientId = message.slice(1);
        this.#getClientIdToHexString();
        console.log(`CLIEND ID ::: ${this.clientIdHexString}`);
        this.#removeListener();
      }
    }

    #getClientIdToHexString() {
      this.clientIdHexString = '';
      for (let i = 0; i < 16; i++) {
        this.clientIdHexString += clientId[i].toString(16);
        if (i == 4 || i == 6 || i == 8 || i == 10) {
          this.clientIdHexString.splice(-2, '-');
        }
      }
    }

    #getClientIdFromHexString(clientIdHexString) {
      let inputString = clientIdHexString.replaceAll('-', '');
      let outputArrayBuffer = new ArrayBuffer(16);
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
