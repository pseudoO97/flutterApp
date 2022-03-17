import 'package:cloud_firestore/cloud_firestore.dart';

class InterventionModel {
  final String firebaseId;
  final dynamic id;
  final int tenantId;
  final bool finished;
  final dynamic accountId;
  final String? accountName;
  final dynamic siteId;
  final String? siteName;

  final String? code;
  final String? address;
  final String? addressComplement;
  final String? city;
  final String? postalCode;
  final String? country;

  final String? scheduledDate;
  final Timestamp? startDate;
  final String? customerSignature;
  final String? technicianSignature;
  final String? customerNote;
  final String? technicianNote;
  final bool registryUpdated;
  final bool labelInstalled;
  final String? registryNotUpdatedReason;
  final String? labelNotInstalledReason;
  // final DateTime? endDate;
  final String? type;
  final String? status;
  final String? label;
  final int? operationId;
  final int? stakeholderId;
  final int? defaultStakeholderId;
  final double? latitude;
  final double? longitude;
  // final String? description;
  // final String? origin;

  InterventionModel({
    required this.firebaseId,
    required this.id,
    required this.tenantId,
    required this.finished,
    this.accountId,
    this.accountName,
    this.siteId,
    this.siteName,
    this.address,
    this.addressComplement,
    this.city,
    this.postalCode,
    this.country,
    this.code,
    // this.cerfaCreated,
    this.customerSignature,
    this.technicianSignature,
    this.customerNote,
    this.technicianNote,
    required this.registryUpdated,
    required this.labelInstalled,
    this.registryNotUpdatedReason,
    this.labelNotInstalledReason,
    // this.currentEquipmentRef,
    // this. scheduledDate,
    // this.date,
    this.scheduledDate,
    this.startDate,
    // this.endDate,
    this.type,
    this.status,
    this.label,
    required this.operationId,
    this.stakeholderId,
    this.defaultStakeholderId,
    this.latitude,
    this.longitude,
    // this.description,
    // this.origin,
  });

  factory InterventionModel.fromMap(
      Map<String, dynamic> data, String firebaseId) {
    dynamic id = data['id'].toString();
    int tenantId = data['tenant_id'];
    bool finished = data['_finished'] ?? false;
    String accountName = data['account_name'];
    dynamic accountId = data['account_id'].toString();
    dynamic siteId = data['site_id'].toString();
    String siteName = data['site_name'];
    String? address = data['_site']['address'];
    String? addressComplement = data['_site']['address_complement'];
    String? city = data['_site']['city'];
    String? postalCode = data['_site']['postal_code'];
    String? country = data['_site']['country'];
    String code = data['code'];
    String? scheduledDate = data['scheduled_date'];
    // bool? cerfaCreated = data['cerfa_created'];
    String? customerSignature = data['_report']['signature_customer'];
    String? technicianSignature = data['_report']['signature_technician'];
    String? customerNote = data['_report']['customer_note'];
    String? technicianNote = data['_report']['technician_note'];
    bool registryUpdated = data['_report']['registry_updated'] ?? false;
    bool labelInstalled = data['_report']['label_installed'] ?? false;
    String? registryNotUpdatedReason =
        data['_report']['registry_not_updated_reason'];
    String? labelNotInstalledReason =
        data['_report']['label_not_installed_reason'];
    Timestamp? startDate = data['start_date'];
    // DateTime? endDate = data['end_date'];
    String type = data['type'];
    String status = data['status'];
    String label = data['label'];
    int? operationId = data['operation_id'];
    int? stakeholderId =
        data['_account'] != null ? data['_account']['stakeholder_id'] : null;
    int? defaultStakeholderId = data['_account'] != null
        ? data['_account']['_default_stakeholder_id']
        : null;
    double? latitude = data['latitude'];
    double? longitude = data['longitude'];
    // String description = data['description'];
    // String origin = data['origin'];

    // DocumentReference? currentEquipmentRef;

    return InterventionModel(
      firebaseId: firebaseId,
      id: id,
      tenantId: tenantId,
      finished: finished,
      accountId: accountId,
      accountName: accountName,
      siteId: siteId,
      siteName: siteName,
      address: address,
      addressComplement: addressComplement,
      postalCode: postalCode,
      country: country,
      city: city,
      code: code,
      customerSignature: customerSignature.toString(),
      technicianSignature: technicianSignature.toString(),
      customerNote: customerNote,
      technicianNote: technicianNote,
      registryUpdated: registryUpdated,
      labelInstalled: labelInstalled,
      registryNotUpdatedReason: registryNotUpdatedReason,
      labelNotInstalledReason: labelNotInstalledReason,
      // date: date,
      scheduledDate: scheduledDate,
      startDate: startDate,
      // endDate: endDate,
      type: type,
      status: status,
      label: label,
      operationId: operationId,
      stakeholderId: stakeholderId,
      defaultStakeholderId: defaultStakeholderId,
      latitude: latitude,
      longitude: longitude,
      // description: description,
      // origin:origin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_finished': finished,
      'account_name': accountName,
      'site_id': siteId,
      'site_name': siteName,
      '_site.address': address,
      '_site.address_complement': address,
      '_site.city': city,
      '_site.postal_code': postalCode,
      '_site.country': country,
      'code': code,
      '_report.customer_signature': customerSignature,
      '_report.technician_signature': technicianSignature,
      '_report.customer_note': customerNote,
      '_report.technician_note': technicianNote,
      '_report.registry_updated': registryUpdated,
      '_report.label_installed': labelInstalled,
      '_report.registry_not_updated_reason': registryNotUpdatedReason,
      '_report.label_not_installed_reason': labelNotInstalledReason,
      'scheduled_date': scheduledDate,
      'start_date': startDate,
      // 'end_date' : endDate,
      'type': type,
      'status': status,
      'label': label,
      // 'description' : description,
      // 'origin' : origin,
      'operation_id': operationId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
