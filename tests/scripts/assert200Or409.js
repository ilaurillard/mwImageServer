client.test('Response status', () => client.assert(
    response.status === 200 || response.status === 409
));
