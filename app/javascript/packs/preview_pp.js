document.addEventListener("DOMContentLoaded", function () {
  const profilePictureUpload = document.getElementById(
    "profile-picture-upload"
  );
  const previewImage = document.getElementById("preview-image");

  previewImage.addEventListener("click", function () {
    profilePictureUpload.click();
  });

  profilePictureUpload.addEventListener("change", function () {
    if (profilePictureUpload.files && profilePictureUpload.files[0]) {
      const reader = new FileReader();

      reader.onload = function (e) {
        previewImage.src = e.target.result;
      };

      reader.readAsDataURL(profilePictureUpload.files[0]);
    }
  });
});
