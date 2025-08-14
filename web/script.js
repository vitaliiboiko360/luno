(function () {
  class WsService {
    static wsUrl = 'wss://uno-game.ddns.com:7192/ws';
    ws;
    constructor() {
      this.ws = new WebSocket('wss://uno-game.ddns.com:7192/ws');
      this.ws.binaryType = 'arraybuffer';
    }

    send(arrayBuffer) {
      this.ws.send(arrayBuffer);
    }

    setOnMessage(callback) {
      this.ws.onmessage = callback;
    }
  }

  window.ws = new WsService();
  window.ws.setOnMessage((message) => {
    // console.log(message.data);
    globalThis.wsOnMessage(message.data);
  });

  console.log(`ws binaryType ${WebSocket.binaryType}`);
})();
