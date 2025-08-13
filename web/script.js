(function () {
  class WsService {
    static wsUrl = 'wss://uno-game.ddns.com:7192/ws';
    ws;
    constructor() {
      ws = new WebSocket(wsUrl);
    }

    send(arrayBuffer) {
      this.ws.send(arrayBuffer);
    }
  }

  window.ws = new WsService();
})();
