enum Event {
  seat('seat'),
  seatAll('seatAll'),
  avatar('avatar'),
  addChangeButton('addChangeButton'),
  removeChangeButton('removeChangeButton'),
  end('end');

  final String name;
  const Event(this.name);
}
