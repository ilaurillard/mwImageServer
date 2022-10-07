<?php

echo 'Listening ...'."\n\n";

$sock = socket_create(AF_INET, SOCK_STREAM, 0);
if (!socket_bind($sock, '0.0.0.0', 8080)) {
    throw new Exception('Could not bind '.socket_strerror(socket_last_error()));
}
socket_listen($sock);
while (true) {
    $client = socket_accept($sock);
    $input = socket_read(
        $client,
        1024
    );
    $resp = 'HTTP/1.1 200 OK'."\r\n\r\n".'Yo!';
    socket_write($client, $resp, strlen($resp));
    socket_close($client);
}