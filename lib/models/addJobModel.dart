class AddjobModel {
  String? description;
  String? numberOfWorkers;
  String? additionalDetails;
  String? address;
  String? lat;
  String? long;
  String? state;
  String? lga;
  String? pricePerWorker;
  String? category;
  String? jobImages;

  AddjobModel(
      {this.description,
      this.numberOfWorkers,
      this.address,
      this.additionalDetails,
      this.lat,
      this.long,
      this.lga,
      this.state,
      this.pricePerWorker,
      this.category,
      this.jobImages});

  AddjobModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    numberOfWorkers = json['number_of_workers'];
    address = json['address'];
    additionalDetails = json['additionalDetails'];
    lat = json['lat'];
    long = json['long'];
    state = json['state'];
    lga = json['lga'];
    pricePerWorker = json['price_per_worker'];
    category = json['job_type'];
    jobImages = json['job_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['numberOfWorkers'] = this.numberOfWorkers;
    data['address'] = this.address;
    data['additionalDetails'] = this.additionalDetails;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['state'] = this.state;
    data['lga'] = this.lga;
    data['job_type'] = this.category;
    data['price_per_worker'] = this.pricePerWorker;
    data['job_images'] = this.jobImages;

    return data;
  }
}
