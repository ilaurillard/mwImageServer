client.test('Response status', () => client.assert(
    response.status === 200
));
client.test('Response type', () => client.assert(
    response.contentType.mimeType == 'image/jpeg'
));