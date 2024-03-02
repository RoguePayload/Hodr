document.addEventListener("DOMContentLoaded", function() {
    const ads = [
        { title: "GoFundMe", subtitle: "Help Us Raise Funds", description: "In today’s digital age...", link: "https://www.gofundme.com/f/launch-our-dream-building-a-social-media-platform?utm_campaign=p_lico+share-sheet&utm_medium=copy_link&utm_source=customer", image: "https://images.gofundme.com/qPB-2xgLP1j_y8aW4Z7PXO0a90c=/720x405/https://d2g8igdw686xgo.cloudfront.net/78494051_1708748207509277_r.png", duration: 10000 },
        { title: "LakePointe Church", subtitle: "Discover God, Find a Calling, Make A Difference", description: "Lakepointe Church is celebrating Easter...", link: "https://lakepointe.church", image: "https://scontent-dfw5-1.xx.fbcdn.net/v/t1.6435-9/117769166_3549992865045841_7815458755411706069_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=be3454&_nc_ohc=pFrtuMsNOpcAX882CQ7&_nc_ht=scontent-dfw5-1.xx&oh=00_AfA-3DNuY9OgcalFGEpLzsmsjS5bUy_o-ycuZmaBdOTl2A&oe=660A819E", duration: 30000 }
        // Add more ads as needed
    ];
    let currentAdIndex = 0;

    function rotateAds() {
        const ad = ads[currentAdIndex];
        document.getElementById("ad-link").href = ad.link;
        document.getElementById("ad-link").textContent = ad.title;
        document.getElementById("ad-subtitle").textContent = ad.subtitle;
        document.getElementById("ad-description").textContent = ad.description;
        document.getElementById("ad-image").src = ad.image;

        // Set timeout for next ad
        setTimeout(rotateAds, ad.duration);

        // Update the index for the next ad
        currentAdIndex = (currentAdIndex + 1) % ads.length;
    }

    rotateAds(); // Start rotating ads
});
