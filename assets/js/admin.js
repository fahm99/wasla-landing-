/**
 * Admin JavaScript
 * Manages the waitlist admin functionality
 */

let waitlistData = [];

// Initialize the page
document.addEventListener('DOMContentLoaded', async () => {
    try {
        // Initialize Supabase
        await initSupabase();
        
        // Load data
        await loadWaitlist();
        
        // Add refresh button
        setupRefreshButton();
    } catch (error) {
        console.error('Error initializing admin:', error);
        showError('فشل في تحميل البيانات');
    }
});

/**
 * Load waitlist data from Supabase
 */
async function loadWaitlist() {
    try {
        const data = await waitlistService.getWaitlist();
        waitlistData = data || [];
        renderTable();
        updateStats();
    } catch (error) {
        console.error('Error loading waitlist:', error);
        showError('فشل في تحميل قائمة الانتظار');
    }
}

/**
 * Render the waitlist table
 */
function renderTable() {
    const tbody = document.getElementById('waitlistTable');
    
    if (!tbody) return;
    
    if (waitlistData.length === 0) {
        tbody.innerHTML = `
            <tr>
                <td colspan="6" class="empty-state">لا توجد بيانات</td>
            </tr>
        `;
        return;
    }
    
    tbody.innerHTML = waitlistData.map((entry, index) => {
        const createdAt = new Date(entry.created_at).toLocaleDateString('ar-SA', {
            year: 'numeric',
            month: 'long',
            day: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
        
        const userTypeLabel = getUserTypeLabel(entry.user_type);
        
        const emailStatus = entry.email_sent 
            ? `<span class="status-badge sent"><i class="fas fa-check"></i> تم الإرسال</span>`
            : `<span class="status-badge pending"><i class="fas fa-clock"></i> بانتظار الإرسال</span>`;
        
        return `
            <tr>
                <td>${index + 1}</td>
                <td>${entry.email}</td>
                <td><span class="user-type-badge">${userTypeLabel}</span></td>
                <td class="date-cell">${createdAt}</td>
                <td>${emailStatus}</td>
                <td>
                    <div class="action-buttons">
                        ${!entry.email_sent ? `
                            <button class="btn-action primary" onclick="sendEmail('${entry.id}')">
                                <i class="fas fa-paper-plane"></i> إرسال
                            </button>
                        ` : ''}
                    </div>
                </td>
            </tr>
        `;
    }).join('');
}

/**
 * Update statistics
 */
function updateStats() {
    const totalCount = document.getElementById('totalCount');
    const sentCount = document.getElementById('sentCount');
    
    if (totalCount) {
        totalCount.textContent = waitlistData.length;
    }
    
    if (sentCount) {
        const sent = waitlistData.filter(entry => entry.email_sent).length;
        sentCount.textContent = sent;
    }
}

/**
 * Send email to a specific user
 */
async function sendEmail(id) {
    try {
        await waitlistService.markEmailAsSent(id);
        
        // Update local data
        const index = waitlistData.findIndex(entry => entry.id === id);
        if (index !== -1) {
            waitlistData[index].email_sent = true;
            waitlistData[index].email_sent_at = new Date().toISOString();
        }
        
        // Re-render
        renderTable();
        updateStats();
        
        alert('تم تحديث حالة الإيميل بنجاح');
    } catch (error) {
        console.error('Error sending email:', error);
        alert('فشل في تحديث حالة الإيميل');
    }
}

/**
 * Get Arabic label for user type
 */
function getUserTypeLabel(userType) {
    const types = {
        'student': 'طالب',
        'trainer': 'مدرب',
        'university': 'جامعة',
        'institute': 'معهد',
        'training_center': 'مركز تدريبي'
    };
    
    return types[userType] || userType;
}

/**
 * Setup refresh button
 */
function setupRefreshButton() {
    // Add a refresh button to the header
    const header = document.querySelector('.content-header');
    if (header) {
        const refreshBtn = document.createElement('button');
        refreshBtn.className = 'btn-action primary';
        refreshBtn.innerHTML = '<i class="fas fa-sync-alt"></i> تحديث';
        refreshBtn.style.marginRight = 'auto';
        refreshBtn.onclick = loadWaitlist;
        
        const headerStats = header.querySelector('.header-stats');
        if (headerStats) {
            headerStats.after(refreshBtn);
        }
    }
}

/**
 * Show error message
 */
function showError(message) {
    const tbody = document.getElementById('waitlistTable');
    if (tbody) {
        tbody.innerHTML = `
            <tr>
                <td colspan="6" class="error-state">${message}</td>
            </tr>
        `;
    }
}

// Export for global use
window.sendEmail = sendEmail;
window.loadWaitlist = loadWaitlist;