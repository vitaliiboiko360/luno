(function () {
  class WsService {
    static wsUrl = 'wss://uno-game.ddns.com:7192/ws';
    ws;
    constructor() {
      this.ws = new WebSocket(WsService.wsUrl);
      this.ws.binaryType = 'arraybuffer';
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

  window.ws = new WsService();
  window.ws.setOnMessage((message) => {
    if (globalThis.wsOnMessage) {
      globalThis.wsOnMessage(message.data);
    }
  });
})();
