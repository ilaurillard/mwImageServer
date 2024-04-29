// PAT from https://id.atlassian.com/manage-profile/security/api-tokens
// ATATT3xFfGF0F_JOZxE-2m-STwCwr2scjcz_MYJIc_XNmpqfiveK-kcBynC_9jvFHnM_NUSFW2TcKDwDQzREw8sGkgJR7zJAZdQOsCcCbStZ3F3Ui0ZaNIiILOTJmcLC_tPaljHWl1XKhBwEXfPC2_QWgIGTm0lEh3CKy9belEqQoQTf8vXHQlE=E749C877

// base64('ilaurillard@mindworks.de:' + PAT)

// curl -H "Authorization: Basic aWxhdXJpbGxhcmRAbWluZHdvcmtzLmRlOkFUQVRUM3hGZkdGMEZfSk9aeEUtMm0tU1R3Q3dyMnNjamN6X01ZSkljX1hObXBxZml2ZUsta2NCeW5DXzlqdkZIbk1fTlVTRlcyVGNLRHdEUXpSRXc4c0drZ0pSN3pKQVpkUU9zQ2NDYlN0WjNGM1VpMFphTklpSUxPVEptY0xDX3RQYWxqSFdsMVhLaEJ3RVhmUEMyX1FXZ0lHVG0wbEVoM0NLeTliZWxFcVFvUVRmOHZYSFFsRT1FNzQ5Qzg3Nw==" https://mindworks.atlassian.net/rest/api/latest/issue/ALVE-1000

// curl -H "Authorization: Basic aWxhdXJpbGxhcmRAbWluZHdvcmtzLmRlOkFUQVRUM3hGZkdGMC1YdEVDMEYxdGliOUc1WFV6QTAwMXNUV0o5blJwZnRiRDJUZFE5YXpmN2lqRnJfbUFQNF9IQjFFM1Y3RlFmSXQyMVhuMnpTODF2NUdpaEtpOHIxT2JzeEd1bUF5cndmTF9aQm5QeFd6WHVTUU91cFlKbFY4dDJteng5R1VtMEFhcG8wSG9ESWFXcmVXZDh5X0Y3UElkSlRoNklleXlRNHhveEpndGg4Z2VkTT03OEEwQkRGNg==" "https://mindworks.atlassian.net/rest/api/latest/search?jql=project=ALVE%20AND%20issue=ALVE-1000"

// ignore_for_file: unnecessary_string_escapes

import 'package:html/dom.dart';
import 'package:html/parser.dart';

void main() {
  String descr =
      '<h5><a name=\"Problembeschreibung\"></a>Problembeschreibung</h5>\n\n<p>Tankstellenfotos mit Umlauten im Namen wurde nicht importiert.</p>\n\n<ul>\n\t<li>Neuer Datenbestand liegt vor → bei Heinz auf dem Rechner</li>\n\t<li>Ablauf\n\t<ul>\n\t\t<li><img class=\"emoticon\" src=\"/images/icons/emoticons/check.png\" height=\"16\" width=\"16\" align=\"absmiddle\" alt=\"\" border=\"0\"/> Daten auf den Elaflex-Server übertragen</li>\n\t\t<li><img class=\"emoticon\" src=\"/images/icons/emoticons/check.png\" height=\"16\" width=\"16\" align=\"absmiddle\" alt=\"\" border=\"0\"/> nicht importierte Fotos identifizieren und zuordnen</li>\n\t\t<li>Import der fehlenden Fotos</li>\n\t</ul>\n\t</li>\n</ul>\n';

  Document document = parse(
    descr,
  );
  print(document.outerHtml);



}
