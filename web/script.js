(function () {
  class WsService {
    static wsUrl = 'wss://uno-game.ddns.com:7190/ws';
    ws;
    constructor() {
      ws = new WebSocket(wsUrl);
    }
  }
})();
