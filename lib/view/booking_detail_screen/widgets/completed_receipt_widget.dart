import 'package:flutter/material.dart';
import 'package:project_2_provider/model/booking_request_model.dart';

class CompletedReceiptWidget extends StatelessWidget {
  final BookingRequest request;

  const CompletedReceiptWidget({super.key, required this.request});

  String _formatDateTime(DateTime? dt) {
    if (dt == null) return 'N/A';
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '${dt.day}/${dt.month}/${dt.year} at ${hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    final isPaid = request.paymentStatus == 'paid';
    final totalAmount = request.price + (request.extraCharges ?? 0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Payment Status Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isPaid
                      ? [Colors.green.shade50, Colors.green.shade100]
                      : [Colors.orange.shade50, Colors.orange.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isPaid ? Colors.green.shade300 : Colors.orange.shade300,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  // Status Header
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isPaid ? Colors.green : Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          isPaid ? Icons.check_circle : Icons.pending_actions,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isPaid ? 'Payment Received' : 'Payment Pending',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isPaid ? Colors.green.shade800 : Colors.orange.shade800,
                            ),
                          ),
                          Text(
                            isPaid
                                ? 'Customer has paid successfully'
                                : 'Waiting for customer payment',
                            style: TextStyle(
                              fontSize: 12,
                              color: isPaid ? Colors.green.shade600 : Colors.orange.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  Divider(
                    color: isPaid ? Colors.green.shade200 : Colors.orange.shade200,
                    height: 1,
                  ),
                  const SizedBox(height: 16),

                  // Receipt Rows
                  _buildReceiptRow(
                    'Base Charge',
                    '₹${request.price.toStringAsFixed(2)}',
                  ),

                  if ((request.extraCharges ?? 0) > 0) ...[
                    const SizedBox(height: 8),
                    _buildReceiptRow(
                      'Extra Charges (₹200/hr)',
                      '₹${request.extraCharges!.toStringAsFixed(2)}',
                      valueColor: Colors.orange.shade700,
                    ),
                  ],

                  if (request.totalWorkHours != null) ...[
                    const SizedBox(height: 8),
                    _buildReceiptRow(
                      'Total Hours',
                      '${request.totalWorkHours!.toStringAsFixed(2)} hrs',
                      valueColor: Colors.grey.shade700,
                    ),
                  ],

                  const SizedBox(height: 12),
                  Divider(color: Colors.grey.shade300, height: 1),
                  const SizedBox(height: 12),

                  // Total
                  _buildReceiptRow(
                    'Total Amount',
                    '₹${totalAmount.toStringAsFixed(2)}',
                    isTotal: true,
                    valueColor: isPaid ? Colors.green.shade700 : Colors.black87,
                  ),

                  // Payment ID (if paid)
                  if (isPaid && request.paymentId != null) ...[
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.green.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.receipt_long,
                              size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          Text(
                            'Payment ID: ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              request.paymentId!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Completed At
                  if (request.completedAt != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.access_time,
                            size: 14, color: Colors.grey.shade500),
                        const SizedBox(width: 6),
                        Text(
                          'Completed: ${_formatDateTime(request.completedAt)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptRow(
    String label,
    String value, {
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black87,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? Colors.black87,
          ),
        ),
      ],
    );
  }
}