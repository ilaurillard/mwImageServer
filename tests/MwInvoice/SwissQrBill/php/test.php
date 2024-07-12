<?php
ini_set('display_errors', 1);
error_reporting(E_ALL);

use Sprain\SwissQrBill as QrBill;

require __DIR__.'/vendor/autoload.php';
$qrBill = QrBill\QrBill::create();

//Kreditoren Informationen eintragen (Wer erhält das Geld?)
$qrBill->setCreditor(
    QrBill\DataGroup\Element\CombinedAddress::create(
        'Robert Schneider AG',
        'Rue du Lac 1268',
        '2501 Biel',
        'CH'
    )
);

$qrBill->setCreditorInformation(
    QrBill\DataGroup\Element\CreditorInformation::create(
        'CH4431999123000889012' // Hier muss die spezielle IBAN Nummer eingetragen werden
    )
);

//Debitor, Rechnungsempfänger Adresse
$qrBill->setUltimateDebtor(
    QrBill\DataGroup\Element\StructuredAddress::createWithStreet(
        'Pia-Maria Rutschmann-Schnyder',
        'Grosse Marktgasse',
        '28',
        '9400',
        'Rorschach',
        'CH'
    )
);


$qrBill->setPaymentAmountInformation(
    QrBill\DataGroup\Element\PaymentAmountInformation::create(
        'CHF',
        2500.25 //Der zuzahlende Betrag in Franken
    )
);

$referenceNumber = QrBill\Reference\QrPaymentReferenceGenerator::generate(
    '210000',
    // fix definierte Nummer, kann von der Bank bezogen werden
    '313947143000901' // individuelle Nummer um die Bestellung eindeutig seinen Auftragsdaten zuzuordnen z.b. AuftragsId.
);

$qrBill->setPaymentReference(
    QrBill\DataGroup\Element\PaymentReference::create(
        QrBill\DataGroup\Element\PaymentReference::TYPE_QR,
        $referenceNumber
    )
);

foreach ($qrBill->getViolations() as $v) {
    print 'FEHLER: '.$v->getMessage()."\n";
}

print($qrBill->getQrCodeContent());
print("\n");


//Nur QR-Code als Bild
//try {
//    $qrBill->getQrCode()->writeFile(__DIR__ . '/qr.png');
//    $qrBill->getQrCode()->writeFile(__DIR__ . '/qr.svg');
//} catch (Exception $e) {

//    foreach($qrBill->getViolations() as $violation) {
//        print $violation->getMessage()."\n";
//    }
//}

//// … oder gleich das ganze Rechnungsdokument als PDF
//$output = new QrBill\PaymentPart\Output\HtmlOutput\HtmlOutput($qrBill, 'en');
//
//print $output
//    ->setPrintable(false)
//    ->setQrCodeImageFormat(QrBill\QrCode\QrCode::FILE_FORMAT_SVG)
//    ->getPaymentPart();



//echo 'done'."\n\n";