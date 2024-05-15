import 'dart:convert';

// Class to represent a Testimonial
class Testimonial {
  final int id;
  final String title;
  final String videoLink;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Testimonial({
    required this.id,
    required this.title,
    required this.videoLink,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert JSON to a Testimonial object
  factory Testimonial.fromJson(Map<String, dynamic> json) {
    return Testimonial(
      id: json['id'],
      title: json['title'],
      videoLink: json['videolink'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  // Convert a Testimonial object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'videolink': videoLink,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

// Class to represent the entire response
class TestimonialResponse {
  final int status;
  final String message;
  final List<Testimonial> testimonials;

  TestimonialResponse({
    required this.status,
    required this.message,
    required this.testimonials,
  });

  // Convert JSON to a TestimonialResponse object
  factory TestimonialResponse.fromJson(Map<String, dynamic> json) {
    var testimonialList = (json['data']['testimonial'] as List)
        .map((item) => Testimonial.fromJson(item))
        .toList();

    return TestimonialResponse(
      status: json['status'],
      message: json['message'],
      testimonials: testimonialList,
    );
  }

  // Convert a TestimonialResponse object to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'testimonial': testimonials.map((t) => t.toJson()).toList(),
      },
    };
  }
}
