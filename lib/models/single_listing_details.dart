class SingleListingDetails{
  String id;
  String name;
  String image;
  String type;
  int available;
  List<dynamic> allImageArray;
  String description;
  String listingAddress;
  String addressLatLang;
  String emailId;
  String contactPersonName;
  String contactNumber;
  String websiteLisnk;
  String facebookLink;
  String googleLink;
  String googlePlusLink;
  String instagramLink;
  String linkedInLink;
  String serviceLocation;
  String sitePincode;
  String establishmentYear;
  String companyStatus;
  String serviceProductList;
  List<Product> productList;
  String gstNumber;
  String openHours;
  String highlightedData;
  String youtubeid;
  String profile_pdf_link;
  String service_available_in;

  SingleListingDetails(
      this.id,
      this.name,
      this.image,
      this.type,
      this.available,
      this.allImageArray,
      this.description,
      this.listingAddress,
      this.addressLatLang,
      this.emailId,
      this.contactPersonName,
      this.contactNumber,
      this.websiteLisnk,
      this.facebookLink,
      this.googleLink,
      this.googlePlusLink,
      this.instagramLink,
      this.linkedInLink,
      this.serviceLocation,
      this.sitePincode,
      this.establishmentYear,
      this.companyStatus,
      this.serviceProductList,
      this.productList,
      this.gstNumber,
      this.openHours,
      this.highlightedData,
      this.youtubeid,
      this.profile_pdf_link,
      this.service_available_in, );
}


class Product{

  String productName;
  String productImageUrl;
  String productCost;
  String productDescription;

  Product(this.productName, this.productImageUrl, this.productCost, this.productDescription);
}
