let slideIndex = {}; // Object om de index per slideshow op te slaan

function showSlides(n, slideshowId) {
    if (!slideIndex[slideshowId]) { // Initialiseer index indien nog niet gedaan
        slideIndex[slideshowId] = 1;
    }

    let i;
    let slides = document.querySelectorAll(`#${slideshowId} .mySlides`);

    if (n > slides.length) { slideIndex[slideshowId] = 1 }
    if (n < 1) { slideIndex[slideshowId] = slides.length }

    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }

    slides[slideIndex[slideshowId] - 1].style.display = "block";
}

function plusSlides(n, slideshowId) {
    showSlides(slideIndex[slideshowId] += n, slideshowId);
}

// Initialiseer beide slideshows
showSlides(1, 'over-ons-slideshow');
showSlides(1, 'menu-slideshow');