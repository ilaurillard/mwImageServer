client.test('Response status', () => client.assert(
    response.status === 403
));
client.test('Response type', () => client.assert(
    response.contentType.mimeType == 'application/json'
));