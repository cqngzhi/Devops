<?php
// Stel de content type in om correcte weergave van tekens te garanderen (UTF-8)
header('Content-Type: text/html; charset=UTF-8');

// Controleer of het verzoek via POST is verzonden (formulier ingediend)
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Haal de formulierdata op en maak deze schoon om eenvoudige aanvallen te voorkomen
    $name = strip_tags(trim($_POST['name'])); // Verwijder HTML tags en spaties aan begin en eind
    $email = strip_tags(trim($_POST['email']));
    $message = strip_tags(trim($_POST['message']));

    // Valideer het e-mailformaat
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo '<p style="color: red;">Ongeldig e-mailformaat.</p>'; // Ongeldig formaat bericht
        exit; // Stop het script
    }

    $to = 'jouw_doel_email@example.com'; // VERANDER DIT NAAR JE EIGEN E-MAILADRES! (Wijzig dit naar het e-mailadres waar je de berichten wilt ontvangen)
    $subject = 'Website contactformulier inzending'; // Onderwerp van de e-mail

    // Bouw de e-mail body
    $body = "Naam: $name\n";
    $body .= "E-mail: $email\n\n";
    $body .= "Bericht:\n$message";

    // Bouw de e-mail headers (ZEER BELANGRIJK!)
    $headers = "From: " . $email . "\r\n"; // Afzender (het e-mailadres dat de gebruiker heeft ingevuld)
    $headers .= "Reply-To: " . $email . "\r\n"; // Antwoordadres (waarop je antwoordt als je op "Beantwoorden" klikt)
    $headers .= "Content-Type: text/plain; charset=UTF-8\r\n"; // Inhoudstype en tekenset (essentieel voor correcte weergave van speciale tekens)
    // Extra headers (optioneel, maar aanbevolen voor betere compatibiliteit):
    $headers .= "MIME-Version: 1.0\r\n"; // MIME versie
    // $headers .= "Cc: cc_email@example.com\r\n"; // Carbon Copy (CC) - Kopie naar... (zichtbaar voor alle ontvangers)
    // $headers .= "Bcc: bcc_email@example.com\r\n"; // Blind Carbon Copy (BCC) - Blinde Kopie naar... (niet zichtbaar voor andere ontvangers)

    // Probeer de e-mail te verzenden met de mail() functie
    if (mail($to, $subject, $body, $headers)) {
        echo '<p style="color: green;">Uw bericht is succesvol verzonden!</p>'; // Succesbericht
    } else {
        echo '<p style="color: red;">Er is een fout opgetreden bij het verzenden van uw bericht. Probeer het later opnieuw.</p>'; // Foutbericht
        // Log de fout voor debuggen (aanbevolen)
        error_log("Failed to send email. Errors: " . error_get_last()['message']);
    }
}
?>
