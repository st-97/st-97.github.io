import React, { useState, useMemo } from "react";
import logo from '../assets/Group.png'
import bgImage from '../assets/bg.webp'
import axios from "axios";

export default function AngillLaunchPage() {
  const [submitted, setSubmitted] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [role, setRole] = useState("doctor");
  const [hasClinic, setHasClinic] = useState("yes");
  // FAQ state
  const [openFaq, setOpenFaq] = useState(null);

  // Frequently asked questions data
  const faqs = [
    {
      q: 'When will Angill launch?',
      a: 'We plan a staged rollout beginning with a private beta for founding clinics, followed by a public launch. Sign up to be notified for early access.'
    },
    {
      q: 'How does pricing work?',
      a: 'Founding members receive preferential pricing and flexible onboarding installments. Operational fees vary by booking type; details are provided during onboarding.'
    },
    {
      q: 'Do you support multi-location clinics?',
      a: 'Yes — our platform allows multiple locations and terminals per clinic. Early adopters get expanded multi-location capabilities.'
    },
    {
      q: 'Is patient data secure?',
      a: 'We build security and auditability into our scheduling and payment flows. The platform is not for emergency care and follows privacy-by-design principles.'
    }
  ];

  // Decorative gradient circles for background (randomized on first render)
  const circles = useMemo(() => {
    const colorPairs = [
      ['rgba(16,185,129,0.9)', 'rgba(16,185,129,0.25)'], // emerald
      ['rgba(6,182,212,0.85)', 'rgba(99,102,241,0.2)'], // cyan -> indigo
      ['rgba(99,102,241,0.85)', 'rgba(236,72,153,0.18)'], // indigo -> pink
      ['rgba(34,197,94,0.85)', 'rgba(16,185,129,0.18)'], // green blend
      ['rgba(14,165,233,0.85)', 'rgba(6,182,212,0.18)'] // blue-cyan
    ];

    return Array.from({ length: 7 }).map(() => {
      const left = Math.floor(Math.random() * 120) - 10; // -10% to 110%
      const top = Math.floor(Math.random() * 120) - 10;
      const size = `${Math.floor(Math.random() * 600) + 200}px`; // 200-800px
      const pair = colorPairs[Math.floor(Math.random() * colorPairs.length)];
      const rotate = Math.floor(Math.random() * 360);
      const blur = Math.floor(Math.random() * 60) + 30; // 30-90px
      const opacity = (Math.random() * 0.38) + 0.22; // 0.22-0.6
      return { left, top, size, pair, rotate, blur, opacity };
    });
  }, []);

  const onSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError('');

    // Collect form data
    const formData = new FormData(e.target);
    const data = {
      role: role,
      full_name: formData.get('full_name'),
      email: formData.get('email'),
      phone: formData.get('phone'),
      city: formData.get('city'),
      specialty: formData.get('specialty') || '',
      has_clinic: formData.get('has_clinic') || '',
      clinic_address: formData.get('clinic_address') || '',
      notes: formData.get('notes') || ''
    };
    console.log("Url", import.meta.env.VITE_BASE_URL)

    try {
      const response = await axios.post(`${import.meta.env.VITE_BASE_URL}/send-lead-data`, {
        ...data
      });
      console.log(response.data)




      if (response.data.success) {
        setSubmitted(true);
        e.target.reset();
        // Scroll to success message
        window.scrollTo({ top: 0, behavior: 'smooth' });
      } else {
        setError(result.message || 'Something went wrong. Please try again.');
      }

    } catch (err) {
      console.error('Submission error:', err);
      setError('Network error. Please check your connection and try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
<main className="min-h-screen font-inter relative overflow-hidden">
  <div
    className="absolute inset-0 -z-10"
    style={{
      backgroundImage: `linear-gradient(rgba(255,255,255,0.06), rgba(255,255,255,0.06)), url(${bgImage})`,
      backgroundSize: "cover",
      backgroundPosition: "center",
      backgroundRepeat: "no-repeat",
      backgroundAttachment: "fixed",
      transform: "rotate(180deg)",
    }}
  />
  
  
      {/* Subtle gradient background */}
      <div className="fixed inset-0 bg-gradient-to-br from-green-50/30 via-white to-emerald-50/20 pointer-events-none" />
        {/* Decorative gradient circles (randomized) */}
        <div className="fixed inset-0 pointer-events-none" style={{ zIndex: -1 }}>
          {circles.map((c, i) => (
            <div
              key={i}
              style={{
                position: 'absolute',
                left: `${c.left}%`,
                top: `${c.top}%`,
                width: c.size,
                height: c.size,
                borderRadius: '50%',
                transform: `translate(-50%, -50%) rotate(${c.rotate}deg)`,
                background: `radial-gradient(circle at 30% 30%, ${c.pair[0]} 0%, ${c.pair[1]} 45%, rgba(255,255,255,0) 100%)`,
                filter: `blur(${c.blur}px)`,
                opacity: c.opacity
              }}
            />
          ))}
        </div>

        {/* background image moved to main element style for reliable rendering */}

      {/* Header */}
      <div className="relative z-10">
        {/* Header */}
        <header className="w-full px-6 lg:px-12 py-2">
          <div className="max-w-[1600px] mx-auto flex flex-col md:flex-row md:items-center md:justify-between gap-2">

            {/* Top row: Logo + Email */}
            <div className="flex items-center justify-between w-full md:w-auto gap-3">
              {/* Logo */}
              <div className="flex items-center gap-3">
                <div className="h-11 w-11 rounded-sm bg-gradient-to-br from-green-400 to-emerald-500 shadow-lg shadow-green-500/20 grid place-items-center">
                  <img src={logo} className="p-1" />
                </div>
                <span className="text-xl font-bold bg-gradient-to-r from-gray-900 to-gray-700 bg-clip-text text-transparent">Angill</span>
              </div>

              {/* Email */}
              <div className="flex items-center gap-1 bg-white/60 backdrop-blur-md rounded-full px-4 py-2 border border-gray-200/50 shadow-sm">
                <svg className="w-4 h-4 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                </svg>
                <span className="text-sm text-gray-700 font-medium">info@angill.com</span>
              </div>
            </div>

            {/* Banner Text */}
            <div className="w-full md:w-auto text-center md:text-left rounded-full px-4 py-2  shadow-sm bg-white border border-emerald-200  text-xl text-emerald-600 font-bold">
              Run your clinic on your own time — not your clinic's time.
            </div>

          </div>
        </header>





        {/* Banner */}


        {/* Hero Section */}
        <section className="w-full px-2 lg:px-12 py-8 lg:py-8">
          <div className="max-w-[1600px] mx-auto">
            <div className="gap-3 lg:gap-2 items-start grid lg:grid-cols-2 gap-y-4 gap-x-2">
              {/* Left Column */}
              <div className="space-y-8">
                <div>
                  <span className="inline-flex items-center gap-2 text-xs font-semibold tracking-wide uppercase bg-gradient-to-r from-green-500 to-emerald-500 text-white rounded-full px-4 py-1.5 shadow-lg shadow-green-500/20">
                    <span className="w-1.5 h-1.5 bg-white rounded-full animate-pulse" />
                    Coming Soon
                  </span>
                </div>

                {/* New Tagline Section */}
                <div className="space-y-3">
                  <h2 className="text-2xl lg:text-3xl font-bold bg-gradient-to-r from-gray-900 to-gray-700 bg-clip-text text-transparent">
                    Where online and offline healthcare finally meet
                  </h2>
                  <p className="text-base lg:text-lg text-gray-600 leading-relaxed">
                    Angill Hybrid Healthcare is bridging the healthcare divide between the internet-connected and the unconnected, transforming how medical services reach people. By blending physical clinics with digital innovation, we make quality healthcare accessible, inclusive, and reliable — for everyone, everywhere.
                  </p>
                </div>

                <h1 className="text-4xl lg:text-6xl font-bold leading-tight">
                  <span className="bg-gradient-to-r from-gray-900 via-gray-800 to-gray-900 bg-clip-text text-transparent">
                    Hybrid Healthcare for the real world —
                  </span>
                  <span className="block mt-2 bg-gradient-to-r from-green-500 to-emerald-500 bg-clip-text text-transparent">
                    double capacity, not infrastructure.
                  </span>
                </h1>

                <p className="text-lg lg:text-xl text-gray-600 leading-relaxed">
                  Built for developing markets. A discreet, end‑to‑end system that helps doctors and clinics serve more patients with existing resources.
                </p>

                {/* Features Grid: 2 columns, last card spans full width */}
                <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
                  <Feature icon="⚡" title="Instant Sign‑Up Preview" desc="explore the dashboard before onboarding." />
                  <Feature icon="🏥" title="Clinic Module + Admin" desc="run clinics up to 12h with staff on‑site and you on‑call." />
                  <Feature icon="📅" title="Smart Dual‑Slot Calendar" desc="prevents double‑booking across clinic & online." />
                  <Feature icon="💰" title="Fair Fees" desc="in‑clinic bookings 15–20% (others 30%+); weekly early settlements." />
                  {/* Full width card on small/medium screens will span both columns on md+ */}
                  <Feature className="md:col-span-2" icon="🛡️" title="Risk‑Free" desc="refundable onboarding, installments as you earn, 20% referral credits." />
                </div>
              </div>

              {/* Right Column - Form Card */}
              <div className="lg:sticky lg:top-8 space-y-3 mt-3 max-w-xl mx-auto">
                
                <div className="bg-white/70 backdrop-blur-xl border border-gray-200/50 rounded-3xl p-8 shadow-2xl shadow-gray-200/50">
                  <div className="mb-6">
                    <h2 className="text-2xl font-bold text-gray-900 mb-2">Register your interest</h2>
                    <p className="text-gray-500">Business opportunity • Extra earning • Early access</p>
                  </div>

                  {/* Success Message */}
                  {submitted && (
                    <div className="mb-6 rounded-2xl bg-gradient-to-r from-green-50 to-emerald-50 border border-green-200/50 p-4">
                      <div className="flex items-start gap-3">
                        <div className="flex-shrink-0 w-6 h-6 rounded-full bg-green-500 flex items-center justify-center">
                          <svg className="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M5 13l4 4L19 7" />
                          </svg>
                        </div>
                        <div className="flex-1">
                          <p className="text-sm text-green-700 font-medium">Thank you! You're on the early access list.</p>
                          <p className="text-xs text-green-600 mt-1">We'll reach out from <b>info@angill.com</b></p>
                        </div>
                      </div>
                    </div>
                  )}

                  {/* Error Message */}
                  {error && (
                    <div className="mb-6 rounded-2xl bg-gradient-to-r from-red-50 to-rose-50 border border-red-200/50 p-4">
                      <div className="flex items-start gap-3">
                        <div className="flex-shrink-0 w-6 h-6 rounded-full bg-red-500 flex items-center justify-center">
                          <svg className="w-4 h-4 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M6 18L18 6M6 6l12 12" />
                          </svg>
                        </div>
                        <div className="flex-1">
                          <p className="text-sm text-red-700 font-medium">{error}</p>
                        </div>
                      </div>
                    </div>
                  )}

                  {/* Role Selection as 2x2 Cards */}
                  <div className="mb-3">
                    <div className="mb-3 flex items-center gap-2">
                      <label className="text-4xl font-bold text-emerald-500 font-serif">
                        I am a
                      </label>

                      {/* Selected Role shown as a tag */}
                      {role && (
                        <span className="px-4 py-2 rounded-xl bg-emerald-500 text-white font-semibold text-lg">
                          {role === "doctor" ? "Doctor" :
                            role === "pharmacy" ? "Pharmacy" :
                              role === "nurse" ? "Nursing" :
                                "Med Rep"}
                        </span>
                      )}
                    </div>



                    {/* Selected Role Dropdown - show once role is selected */}
                    {role && (
                      <div className="max-w-xl mx-auto mt-3 py-2">
                        <select
                          value={role}
                          onChange={(e) => setRole(e.target.value)}
                          className="w-full rounded-md border border-gray-300 px-3 py-2  text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                        >
                          <option value="doctor">Doctor</option>
                          <option value="pharmacy">Pharmacy</option>
                          <option value="nurse">Nursing</option>
                          <option value="rep">Med Rep</option>
                        </select>
                      </div>
                    )}
                  </div>

                  {/* Form - only visible when role is selected */}
                    {role && (
                    <form onSubmit={onSubmit} className="space-y-3 mt-3 mx-auto max-w-xl">

                      {/* Specialty input inline with Role if doctor
                      {role === "doctor" && (
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-2">
                          <div>
                            <label className="block text-xs font-medium text-gray-700 mb-1">Specialty (optional)</label>
                            <input
                              name="specialty"
                              placeholder="e.g., GP, Cardiology"
                              className="w-full rounded-md border border-gray-300 px-3 py-1.5 text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                            />
                          </div>
                        </div>
                      )
                      } */}

                      {/* Doctor-specific fields in single row */}
                      {role === "doctor" && (
                        <div className="grid grid-cols-1 md:grid-cols-2 gap-2">
                          {/* Specialty Input */}
                          <div>
                            <label className="block text-xs font-medium text-gray-700 mb-1">Specialty (optional)</label>
                            <input
                              name="specialty"
                              placeholder="e.g., GP, Cardiology"
                              className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                            />
                          </div>

                          {/* Clinic Ownership Question */}
                          <div className="flex flex-col">
                            <label className="text-xs font-medium text-gray-700 mb-1">
                              Do you have your own clinic?
                            </label>
                            <div className="flex gap-2">
                              {["yes", "no"].map((option) => (
                                <button
                                  key={option}
                                  type="button"
                                  onClick={() => setHasClinic(option)}
                                  className={`flex-1 px-3 py-2 rounded-full text-xs font-medium border transition-all duration-150 text-center
                         ${hasClinic === option
                                         ? "bg-emerald-500 text-white border-emerald-500 shadow"
                                      : "bg-white text-gray-700 border-gray-300 hover:bg-gray-100"
                                    }`}
                                >
                                  {option === "yes" ? "Yes" : "No"}
                                </button>
                              ))}
                            </div>

                          </div>
                        </div>
                      )}

                      {hasClinic === "yes" && (
                        <div className="mt-2">
                          <label className="block text-xs font-medium text-gray-700 mb-1">Clinic Address</label>
                          <input
                            name="clinic_address"
                            placeholder="Full address of your clinic"
                            required
                            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                          />
                        </div>
                      )}



                      {/* Name & Email */}
                      <div className="grid md:grid-cols-2 gap-2">
                        <div>
                          <label className="block text-xs font-medium text-gray-700 mb-1">Full Name</label>
                          <input
                            name="full_name"
                            required
                            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                          />
                        </div>
                        <div>
                          <label className="block text-xs font-medium text-gray-700 mb-1">Email</label>
                          <input
                            name="email"
                            type="email"
                            required
                            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                          />
                        </div>
                      </div>

                      {/* Phone & City */}
                      <div className="grid md:grid-cols-2 gap-2">
                        <div>
                          <label className="block text-xs font-medium text-gray-700 mb-1">Mobile / WhatsApp</label>
                          <input
                            name="phone"
                            required
                            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                          />
                        </div>
                        <div>
                          <label className="block text-xs font-medium text-gray-700 mb-1">City, Country</label>
                          <input
                            name="city"
                            required
                            className="w-full rounded-md border border-gray-300 px-3 py-2 text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500"
                          />
                        </div>
                      </div>



                      {/* Notes */}
                      <div>
                        <label className="block text-xs font-medium text-gray-700 mb-1">Anything we should know? (optional)</label>
                        <textarea
                          name="notes"
                          className="w-full rounded-md border border-gray-300 px-3 py-1.5 text-sm text-gray-700 focus:ring-1 focus:ring-emerald-500 focus:border-emerald-500 resize-none"
                        />
                      </div>

                      {/* Consent */}
                      <div className="flex items-start gap-2 text-xs text-gray-600">
                        <input
                          id="consent"
                          name="consent"
                          type="checkbox"
                          required
                          className="mt-1 w-4 h-4 text-green-500 border-gray-300 rounded focus:ring-green-500"
                        />
                        <label htmlFor="consent">
                          I agree to be contacted by Angill. We respect privacy; data is not sold.
                        </label>
                      </div>

                      {/* Submit */}
                      <button
                        type="submit"
                        disabled={loading}
                        className="w-full rounded-2xl px-6 py-3 bg-gradient-to-r from-green-500 to-emerald-500 text-white font-semibold shadow-sm hover:shadow-md transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
                      >
                        {loading ? 'Submitting...' : 'Join the Early Access List'}
                      </button>

                      <p className="text-xs text-gray-500 text-center leading-relaxed">
                        Submitting is not a commitment. You'll receive curated updates and eligibility for early‑joiner benefits.
                      </p>
                    </form>
                  )}


                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Who We Are - expanded two-column full-width grid */}
        <section className="w-full px-6 lg:px-12 py-12 bg-white">
          <div className="max-w-[2000px] mx-auto">
            <h3 className="text-3xl lg:text-4xl font-bold text-gray-900 text-center mb-8">Who we are</h3>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-10 items-start">
              {/* Left: About Us (detailed) */}
              <div className="prose max-w-none text-gray-700">
                <h4 className="text-2xl font-semibold mb-3">About us</h4>
                <p>
                  Angill Hybrid Healthcare is a product and operations team focused on helping small and medium clinics
                  increase their effective capacity by combining simple on-site clinic workflows with remote-first
                  coordination tools. We build for environments with intermittent connectivity and for teams who need
                  dependable, low-friction software that integrates with day-to-day clinic operations.
                </p>

                <p>
                  Our team brings together clinicians, product designers, and engineers who have experience building
                  healthcare workflows in emerging markets. We prioritise privacy, auditability and a low overhead
                  onboarding experience so clinics can adopt useful features quickly without large up-front costs.
                </p>

                <p>
                  We partner with local clinics and networks to co-design features, pilot improvements, and measure
                  impact. If you'd like to collaborate or run a pilot, register through the early access form and we'll
                  reach out to discuss next steps.
                </p>

                <p className="mt-4 text-sm text-gray-600">Founded by clinicians and builders. Based in (PAKISTAN).</p>
              </div>

              {/* Right: Mission + Core values */}
              <div>
                <h4 className="text-2xl font-semibold mb-3 text-emerald-600">Our mission</h4>
                <ul className="list-disc list-inside text-sm text-gray-700 space-y-2">
                  <li>Make healthcare accessible and reliable across both connected and unconnected communities.</li>
                  <li>Increase clinic capacity without requiring expensive infrastructure upgrades.</li>
                  <li>Provide clinic teams with simple, auditable workflows that reduce friction and administrative load.</li>
                  <li>Protect patient privacy and ensure ethical, safe use of our platform.</li>
                </ul>

                <div className="mt-6">
                  <h5 className="font-semibold mb-2 text-gray-900">Core values</h5>
                  <div className="grid grid-cols-2 gap-3">
                    <div className="p-3 rounded-lg bg-emerald-50 border border-emerald-100 text-sm font-medium text-emerald-700">Patient first</div>
                    <div className="p-3 rounded-lg bg-emerald-50 border border-emerald-100 text-sm font-medium text-emerald-700">Low friction</div>
                    <div className="p-3 rounded-lg bg-emerald-50 border border-emerald-100 text-sm font-medium text-emerald-700">Privacy by design</div>
                    <div className="p-3 rounded-lg bg-emerald-50 border border-emerald-100 text-sm font-medium text-emerald-700">Evidence driven</div>
                  </div>
                </div>

                <div className="mt-6">
                  <h5 className="font-semibold mb-2 text-gray-900">Get involved</h5>
                  <p className="text-sm text-gray-700">Interested in piloting, partnership, or hiring? Reach out at <b>info@angill.com</b> or join the early access list.</p>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* FAQ Section */}
        <section className="w-full px-6 lg:px-12 py-12 bg-gray-50">
          <div className="max-w-[2000px] mx-auto">
            <h3 className="text-3xl lg:text-4xl font-bold text-gray-900 text-center mb-8">Frequently Asked Questions</h3>

            <div className="max-w-3xl mx-auto space-y-3">
              {faqs.map((item, idx) => (
                <div key={idx} className="rounded-xl border border-gray-200 bg-white p-4">
                  <button
                    type="button"
                    aria-expanded={openFaq === idx}
                    onClick={() => setOpenFaq(openFaq === idx ? null : idx)}
                    className="w-full flex items-center justify-between text-left gap-4"
                  >
                    <span className="font-medium text-gray-900">{item.q}</span>
                    <svg className={`w-5 h-5 text-gray-500 transform ${openFaq === idx ? 'rotate-180' : 'rotate-0'}`} viewBox="0 0 20 20" fill="currentColor">
                      <path fillRule="evenodd" d="M5.23 7.21a.75.75 0 011.06.02L10 10.94l3.71-3.71a.75.75 0 111.06 1.06l-4.24 4.24a.75.75 0 01-1.06 0L5.21 8.29a.75.75 0 01.02-1.08z" clipRule="evenodd" />
                    </svg>
                  </button>

                  {openFaq === idx && (
                    <div className="mt-3 text-sm text-gray-700">
                      {item.a}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </section>

        {/* Benefits Section */}
        <section className="w-full px-6 lg:px-12 py-2 bg-gradient-to-b from-transparent to-gray-50/50">
          <div className="max-w-[1600px] mx-auto">
            <div className="text-center mb-12">
              <h3 className="text-3xl lg:text-4xl font-bold text-gray-900 mb-3">Founding Cohort Benefits</h3>
              <p className="text-lg text-gray-600">Early‑joiner advantages for our founding members</p>
            </div>

            <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
              <Benefit
                title="Preview First, Decide Later"
                desc="Explore key workflows before onboarding. No other platform gives dashboard access pre‑payment."
                gradient="from-blue-500/10 to-cyan-500/10"
              />
              <Benefit
                title="Clinic Module + Admin"
                desc="Operate up to 12h with staff on‑site, you on‑call. Admin controls included."
                gradient="from-purple-500/10 to-pink-500/10"
              />
              <Benefit
                title="Multi‑Location & Terminals"
                desc="Early doctors can enable <b>two locations</b> on one module and <b>multiple terminals</b> per site at no extra cost in year one."
                gradient="from-amber-500/10 to-orange-500/10"
              />
              <Benefit
                title="Clinic Runs Without Owner Presence"
                desc="Convert your clinic from a single-doctor dependent setup into a hybrid care center. Your clinic stays operational with staff in-clinic and you or other doctors available remotely — allowing extended clinic hours without needing to be physically present."
                gradient="from-teal-500/10 to-cyan-500/10"
              />
              <Benefit
                title="Multi-Doctor Capability"
                desc="Add multiple doctors to your clinic roster. Same space, same staff, unified records — transforming your clinic into a local healthcare hub."
                gradient="from-violet-500/10 to-fuchsia-500/10"
              />
              <Benefit
                title="Fair Fees"
                desc="In‑clinic bookings 15–20% (others 30%+). Weekly early settlements available."
                gradient="from-green-500/10 to-emerald-500/10"
              />
              <Benefit
                title="Risk‑Free Onboarding"
                desc="Refundable + pay‑as‑you‑earn installments. 20% referral credits to recoup initial cost."
                gradient="from-rose-500/10 to-red-500/10"
              />
              <Benefit
                title="Founding Price"
                desc="Limited launch pricing for clinics. Standard value ~PKR 450k; founding cohort from ~PKR 150k equivalent."
                gradient="from-indigo-500/10 to-purple-500/10"
              />
            </div>
          </div>
        </section>

        {/* Trust Indicators */}
        <section className="w-full px-6 lg:px-12 py-12 bg-white/50 backdrop-blur-sm border-y border-gray-200/50">
          <div className="max-w-[1600px] mx-auto">
            <div className="grid md:grid-cols-3 gap-8 text-center">
              <TrustItem
                icon="🔒"
                title="Patent-pending scheduling"
                desc="Closed‑loop payments • Audit trail by design"
              />
              <TrustItem
                icon="🌍"
                title="Built for developing markets"
                desc="Improves access without heavy CAPEX"
              />
              <TrustItem
                icon="✓"
                title="Ethical & Safe"
                desc="Ethical use policy • Not for emergency care"
              />
            </div>
          </div>
        </section>

        {/* Footer */}
        <footer className="w-full px-6 lg:px-12 py-10">
          <div className="max-w-[1600px] mx-auto">
            <div className="flex flex-col md:flex-row items-center justify-between gap-6 text-sm text-gray-500">
              <p className="font-medium">© {new Date().getFullYear()} Angill Hybrid Healthcare. All rights reserved.</p>
              <div className="flex flex-wrap items-center justify-center gap-4 text-xs">
                <span className="px-3 py-1 bg-gray-100 rounded-full">Beta/MVP</span>

                <span>•</span>
                <span>Not for emergencies</span>
                <span>•</span>
                <span className="font-medium">info@angill.com</span>
              </div>
            </div>
          </div>
        </footer>
      </div>
    </main>
  );
}

function Input({ label, name, type = "text", required = false, placeholder = "" }) {
  return (
    <label className="block">
      <span className="block text-sm font-medium text-gray-700 mb-2">
        {label}{required && <span className="text-green-500 ml-1">*</span>}
      </span>
      <input
        name={name}
        type={type}
        required={required}
        placeholder={placeholder}
        className="w-full bg-white/50 backdrop-blur-sm border border-gray-300/50 rounded-xl px-4 py-2.5 text-sm text-gray-900 placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500/50 focus:border-green-500 transition-all"
      />
    </label>
  );
}

function Textarea({ label, name, placeholder = "" }) {
  return (
    <label className="block">
      <span className="block text-sm font-medium text-gray-700 mb-2">{label}</span>
      <textarea
        name={name}
        placeholder={placeholder}
        rows={3}
        className="w-full bg-white/50 backdrop-blur-sm border border-gray-300/50 rounded-xl px-4 py-2.5 text-sm text-gray-900 placeholder:text-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500/50 focus:border-green-500 transition-all resize-none"
      />
    </label>
  );
}

function Role({ id, label, role, setRole }) {
  const active = role === id;
  return (
    <button
      type="button"
      onClick={() => setRole(id)}
      className={`rounded-xl px-4 py-2.5 text-sm font-medium border transition-all duration-200 ${active
        ? "bg-gradient-to-r from-green-500 to-emerald-500 text-white border-green-400 shadow-lg shadow-green-500/20"
        : "bg-white/50 backdrop-blur-sm border-gray-300/50 text-gray-700 hover:border-green-300 hover:bg-green-50/50"
        }`}
    >
      {label}
    </button>
  );
}

// Feature card used in hero features grid.
// Props: icon, title, desc, optional className to allow grid-span or extra styling.
function Feature({ icon, title, desc, className = "" }) {
  return (
    <div className={`p-0.5 py-2 rounded-2xl border border-emerald-500 bg-emerald-50/60 ${className} transition-all duration-200 shadow-sm hover:shadow-md`}>
      <div className="mt-1 flex justify-center">
        <span className="text-2xl inline-block">{icon}</span>
      </div>
      <div className="relative z-10 text-center">
        <h4 className="font-semibold text-gray-900 mb-1 text-base">{title}</h4>
        <p className="text-xs text-gray-600">{desc}</p>
      </div>
    </div>
  );
}



function Benefit({ title, desc, gradient }) {
  return (
    <div className={`relative overflow-hidden rounded-3xl p-6 bg-gradient-to-br ${gradient} backdrop-blur-sm border border-white/50 hover:scale-[1.02] transition-transform duration-200`}>
      <div className="relative z-10">
        <h4 className="font-bold text-gray-900 mb-2 text-lg" dangerouslySetInnerHTML={{ __html: title }} />
        <p className="text-sm text-gray-700 leading-relaxed" dangerouslySetInnerHTML={{ __html: desc }} />
      </div>
      <div className="absolute inset-0 bg-white/30 backdrop-blur-3xl" />
    </div>
  );
}

function TrustItem({ icon, title, desc }) {
  return (
    <div className="space-y-2">
      <div className="text-3xl">{icon}</div>
      <h4 className="font-semibold text-gray-900">{title}</h4>
      <p className="text-sm text-gray-600">{desc}</p>
    </div>
  );
}
