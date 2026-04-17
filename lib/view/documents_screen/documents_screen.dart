import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_2_provider/controllers/personal_details_provider/personal_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:project_2_provider/constants/app_color.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PersonalDetailsProvider()..loadUser(),
      child: const _DocumentsView(),
    );
  }
}

class _DocumentsView extends StatelessWidget {
  const _DocumentsView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PersonalDetailsProvider>();

    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Documents',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : provider.user == null
              ? const Center(child: Text('Failed to load profile'))
              : _DocumentsTab(),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  DOCUMENTS TAB
// ════════════════════════════════════════════════════════════
class _DocumentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PersonalDetailsProvider>();
    final user = provider.user!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Current verified info ──────────────────────────────────────
          _SectionLabel(
            title: 'Verified Info',
            subtitle: 'Managed by admin — send a request to change',
          ),
          const SizedBox(height: 14),

          _buildVerifiedCard(context, user),
          const SizedBox(height: 28),

          // ── Document photos ────────────────────────────────────────────
          _SectionLabel(title: 'Documents', subtitle: 'Your uploaded documents'),
          const SizedBox(height: 14),
          _buildDocumentPhotos(user),
          const SizedBox(height: 28),

          // ── Request change sections ────────────────────────────────────
          _SectionLabel(
            title: 'Request a Change',
            subtitle: 'Admin will review and apply changes',
          ),
          const SizedBox(height: 14),

          _RequestCard(
            title: 'Update Documents',
            icon: Icons.badge_outlined,
            iconColor: Colors.blue,
            child: _buildDocumentRequest(context, provider),
          ),
          const SizedBox(height: 14),

          _RequestCard(
            title: 'Change Service Type',
            icon: Icons.build_outlined,
            iconColor: Colors.orange,
            child: _buildServiceRequest(context, provider),
          ),
          const SizedBox(height: 14),

          _RequestCard(
            title: 'Update Business Name',
            icon: Icons.business_outlined,
            iconColor: Colors.purple,
            child: _buildBusinessNameRequest(context, provider),
          ),
          const SizedBox(height: 14),

          _RequestCard(
            title: 'Update Bank Details',
            icon: Icons.account_balance_outlined,
            iconColor: Colors.green,
            child: _buildBankRequest(context, provider),
          ),

          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildVerifiedCard(BuildContext context, user) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          _LockedTile(Icons.build_outlined, 'Service Type', user.selectService),
          _Divider(),
          _LockedTile(Icons.business_outlined, 'Business Name', user.businessName),
          _Divider(),
          _LockedTile(
              Icons.account_balance_outlined,
              'Bank Account',
              '••••${user.bankAccountNumber.length > 4 ? user.bankAccountNumber.substring(user.bankAccountNumber.length - 4) : user.bankAccountNumber}'),
          _Divider(),
          _LockedTile(Icons.code, 'IFSC Code', user.bankIfscCode),
          _Divider(),
          _LockedTile(Icons.account_balance, 'Bank Name', user.bankName),
          _Divider(),
          _LockedTile(Icons.person_outline, 'Account Holder', user.accountHolderName),
          _Divider(),
          _LockedTile(Icons.qr_code, 'UPI ID', user.upiId),
        ],
      ),
    );
  }

  Widget _buildDocumentPhotos(user) {
    return Row(
      children: [
        Expanded(
          child: _DocumentPhotoCard(
            label: 'ID Card',
            imageUrl: user.idCardPhoto,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _DocumentPhotoCard(
            label: 'Experience Certificate',
            imageUrl: user.experienceCertificate,
          ),
        ),
      ],
    );
  }

  // ── Document request ───────────────────────────────────────────────────────
  Widget _buildDocumentRequest(
      BuildContext context, PersonalDetailsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ImagePickerRow(
          label: 'New ID Card',
          file: provider.idCardImage,
          onTap: () => provider.pickIdCardImage(),
        ),
        const SizedBox(height: 12),
        _ImagePickerRow(
          label: 'New Certificate',
          file: provider.certificateImage,
          onTap: () => provider.pickCertificateImage(),
        ),
        const SizedBox(height: 16),
        _SubmitButton(
          label: 'Send Document Request',
          isLoading: provider.requestState == SaveState.saving,
          onPressed: (provider.idCardImage == null &&
                  provider.certificateImage == null)
              ? null
              : () async {
                  await provider.sendDocumentChangeRequest();
                  if (context.mounted) {
                    _showFeedback(
                        context, provider.requestState, provider.errorMessage);
                    provider.resetRequestState();
                  }
                },
        ),
      ],
    );
  }

  // ── Service request ────────────────────────────────────────────────────────
  Widget _buildServiceRequest(
      BuildContext context, PersonalDetailsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (provider.servicesLoading)
          const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
        else
          DropdownButtonFormField<String>(
            value: provider.selectedServiceForRequest,
            hint: const Text('Select new service'),
            decoration: _inputDecoration('Service Type', Icons.build_outlined),
            items: provider.services
                .map((s) =>
                    DropdownMenuItem(value: s.name, child: Text(s.name)))
                .toList(),
            onChanged: (val) => provider.setSelectedServiceForRequest(val),
          ),
        const SizedBox(height: 16),
        _SubmitButton(
          label: 'Send Service Request',
          isLoading: provider.requestState == SaveState.saving,
          onPressed: provider.selectedServiceForRequest == null
              ? null
              : () async {
                  await provider.sendServiceChangeRequest();
                  if (context.mounted) {
                    _showFeedback(
                        context, provider.requestState, provider.errorMessage);
                    provider.resetRequestState();
                  }
                },
        ),
      ],
    );
  }

  // ── Business name request ──────────────────────────────────────────────────
  Widget _buildBusinessNameRequest(
      BuildContext context, PersonalDetailsProvider provider) {
    return Column(
      children: [
        _EditField(
          controller: provider.businessNameController,
          label: 'New Business Name',
          icon: Icons.business_outlined,
        ),
        const SizedBox(height: 16),
        _SubmitButton(
          label: 'Send Business Name Request',
          isLoading: provider.requestState == SaveState.saving,
          onPressed: () async {
            if (provider.businessNameController.text.trim().isEmpty) return;
            await provider.sendBusinessNameChangeRequest();
            if (context.mounted) {
              _showFeedback(
                  context, provider.requestState, provider.errorMessage);
              provider.resetRequestState();
            }
          },
        ),
      ],
    );
  }

  // ── Bank request ───────────────────────────────────────────────────────────
  Widget _buildBankRequest(
      BuildContext context, PersonalDetailsProvider provider) {
    return Column(
      children: [
        _EditField(
          controller: provider.accountHolderController,
          label: 'Account Holder Name',
          icon: Icons.person_outline,
        ),
        const SizedBox(height: 12),
        _EditField(
          controller: provider.bankAccountController,
          label: 'Account Number',
          icon: Icons.account_balance_wallet_outlined,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 12),
        _EditField(
          controller: provider.bankIfscController,
          label: 'IFSC Code',
          icon: Icons.code,
          inputFormatters: [
            LengthLimitingTextInputFormatter(11),
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
          ],
        ),
        const SizedBox(height: 12),
        _EditField(
          controller: provider.bankNameController,
          label: 'Bank Name',
          icon: Icons.account_balance_outlined,
        ),
        const SizedBox(height: 12),
        _EditField(
          controller: provider.upiController,
          label: 'UPI ID',
          icon: Icons.qr_code,
        ),
        const SizedBox(height: 16),
        _SubmitButton(
          label: 'Send Bank Details Request',
          isLoading: provider.requestState == SaveState.saving,
          onPressed: () async {
            if (provider.bankAccountController.text.trim().isEmpty) return;
            await provider.sendBankChangeRequest();
            if (context.mounted) {
              _showFeedback(
                  context, provider.requestState, provider.errorMessage);
              provider.resetRequestState();
            }
          },
        ),
      ],
    );
  }

  void _showFeedback(
      BuildContext context, SaveState state, String? errorMessage) {
    final isSuccess = state == SaveState.success;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(isSuccess
          ? 'Request sent! Admin will review it soon.'
          : errorMessage ?? 'Something went wrong'),
      backgroundColor: isSuccess ? AppColors.success : AppColors.rejected,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ));
  }
}

// ════════════════════════════════════════════════════════════
//  REUSABLE WIDGETS
// ════════════════════════════════════════════════════════════

InputDecoration _inputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(color: AppColors.hintText),
    prefixIcon: Icon(icon, color: AppColors.primary, size: 20),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
  );
}

class _EditField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int maxLines;

  const _EditField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: _inputDecoration(label, icon),
    );
  }
}

class _LockedTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _LockedTile(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[400]),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(height: 2),
                Text(value.isNotEmpty ? value : '—',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2937))),
              ],
            ),
          ),
          Icon(Icons.lock_outline, size: 16, color: Colors.grey[300]),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(height: 1, color: Colors.grey[100]),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionLabel({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937))),
        if (subtitle != null)
          Text(subtitle!,
              style: TextStyle(fontSize: 12, color: Colors.grey[500])),
      ],
    );
  }
}

class _RequestCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Widget child;

  const _RequestCard({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          title: Text(title,
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w600)),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          children: [child],
        ),
      ),
    );
  }
}

class _ImagePickerRow extends StatelessWidget {
  final String label;
  final File? file;
  final VoidCallback onTap;

  const _ImagePickerRow(
      {required this.label, required this.file, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color:
                  file != null ? AppColors.primary : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              file != null ? Icons.check_circle : Icons.upload_file,
              color: file != null ? AppColors.primary : Colors.grey,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                file != null ? '$label selected ✓' : 'Tap to select $label',
                style: TextStyle(
                    fontSize: 14,
                    color: file != null ? AppColors.primary : Colors.grey[600]),
              ),
            ),
            if (file != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.file(file!,
                    width: 40, height: 40, fit: BoxFit.cover),
              ),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final String label;
  final bool isLoading;
  final VoidCallback? onPressed;

  const _SubmitButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : Text(label,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class _DocumentPhotoCard extends StatelessWidget {
  final String label;
  final String imageUrl;

  const _DocumentPhotoCard({required this.label, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(12)),
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _placeholder(),
                  )
                : _placeholder(),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.verified, size: 14, color: AppColors.success),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(label,
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: 100,
      color: Colors.grey.shade100,
      child: const Center(
          child: Icon(Icons.image_outlined, color: Colors.grey, size: 32)),
    );
  }
}