/**
 * Modal Component
 * Handles the waitlist modal functionality
 */

// Global state
let currentUserType = 'student';

/**
 * Open the waitlist modal
 * @param {string} userType - Pre-selected user type
 */
function openWaitlistModal(userType = 'student') {
    currentUserType = userType;
    const modal = document.getElementById('waitlistModal');
    const userTypeSelect = document.getElementById('userTypeSelect');
    
    if (userTypeSelect) {
        userTypeSelect.value = userType;
    }
    
    if (modal) {
        modal.classList.add('active');
        // Focus on email input
        setTimeout(() => {
            const emailInput = document.getElementById('emailInput');
            if (emailInput) {
                emailInput.focus();
            }
        }, 100);
    }
}

/**
 * Close the waitlist modal
 */
function closeWaitlistModal() {
    const modal = document.getElementById('waitlistModal');
    if (modal) {
        modal.classList.remove('active');
    }
    // Reset form
    const form = document.getElementById('waitlistForm');
    if (form) {
        form.reset();
    }
}

/**
 * Close the success modal
 */
function closeSuccessModal() {
    const modal = document.getElementById('successModal');
    if (modal) {
        modal.classList.remove('active');
    }
}

/**
 * Show success modal
 */
function showSuccessModal() {
    closeWaitlistModal();
    const modal = document.getElementById('successModal');
    if (modal) {
        modal.classList.add('active');
    }
}

/**
 * Submit the waitlist form
 * @param {Event} event - Form submission event
 */
async function submitWaitlist(event) {
    event.preventDefault();
    
    const emailInput = document.getElementById('emailInput');
    const userTypeSelect = document.getElementById('userTypeSelect');
    const submitBtn = document.getElementById('submitBtn');
    
    if (!emailInput || !userTypeSelect || !submitBtn) {
        console.error('Form elements not found');
        return;
    }
    
    const email = emailInput.value.trim();
    const userType = userTypeSelect.value;
    
    if (!email || !userType) {
        alert('يرجى إدخال البريد الإلكتروني واختيار نوع المستخدم');
        return;
    }
    
    // Validate email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
        alert('يرجى إدخال بريد إلكتروني صحيح');
        return;
    }
    
    // Show loading state
    const originalText = submitBtn.innerHTML;
    submitBtn.innerHTML = '<div class="spinner"></div>';
    submitBtn.disabled = true;
    
    try {
        // Check if email already exists
        const exists = await waitlistService.checkEmailExists(email);
        
        if (exists) {
            alert('هذا البريد الإلكتروني مسجل مسبقاً!');
            submitBtn.innerHTML = originalText;
            submitBtn.disabled = false;
            return;
        }
        
        // Add to waitlist
        await waitlistService.addToWaitlist(email, userType);
        
        // Show success
        showSuccessModal();
        
    } catch (error) {
        console.error('Error submitting form:', error);
        alert('حدث خطأ، يرجى المحاولة مرة أخرى');
    } finally {
        submitBtn.innerHTML = originalText;
        submitBtn.disabled = false;
    }
}

/**
 * Toggle mobile menu
 */
function toggleMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    if (menu) {
        menu.classList.toggle('active');
    }
}

/**
 * Close mobile menu
 */
function closeMobileMenu() {
    const menu = document.getElementById('mobileMenu');
    if (menu) {
        menu.classList.remove('active');
    }
}

// Close modals when clicking outside
document.addEventListener('DOMContentLoaded', () => {
    const waitlistModal = document.getElementById('waitlistModal');
    const successModal = document.getElementById('successModal');
    
    if (waitlistModal) {
        waitlistModal.addEventListener('click', (e) => {
            if (e.target === waitlistModal) {
                closeWaitlistModal();
            }
        });
    }
    
    if (successModal) {
        successModal.addEventListener('click', (e) => {
            if (e.target === successModal) {
                closeSuccessModal();
            }
        });
    }
    
    // Handle escape key to close modals
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            closeWaitlistModal();
            closeSuccessModal();
        }
    });
});

// Export functions for global use
window.openWaitlistModal = openWaitlistModal;
window.closeWaitlistModal = closeWaitlistModal;
window.closeSuccessModal = closeSuccessModal;
window.submitWaitlist = submitWaitlist;
window.toggleMobileMenu = toggleMobileMenu;
window.closeMobileMenu = closeMobileMenu;