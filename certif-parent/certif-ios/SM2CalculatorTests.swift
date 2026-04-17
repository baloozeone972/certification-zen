// certif-ios/CertifAppTests/Domain/SM2CalculatorTests.swift
//
// Unit tests for SM2Calculator — pure domain logic, no mocks needed.
// Mirrors Java SM2AlgorithmTest.java in certif-domain module.

import XCTest
@testable import CertifApp

final class SM2CalculatorTests: XCTestCase {

    // MARK: - Failed recall (rating < 3)

    func test_rating0_resetsInterval() {
        let (interval, ease) = SM2Calculator.calculate(
            rating: 0, easeFactor: 2.5, intervalDays: 10, repetitions: 3
        )
        XCTAssertEqual(interval, 1, "Rating 0 (blackout) must reset interval to 1")
        XCTAssertLessThan(ease, 2.5, "Ease factor must decrease on failed recall")
        XCTAssertGreaterThanOrEqual(ease, 1.3, "Ease factor must not drop below 1.3")
    }

    func test_rating1_resetsInterval() {
        let (interval, ease) = SM2Calculator.calculate(
            rating: 1, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertEqual(interval, 1)
        XCTAssertLessThan(ease, 2.5)
    }

    func test_rating2_resetsInterval() {
        let (interval, _) = SM2Calculator.calculate(
            rating: 2, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertEqual(interval, 1)
    }

    // MARK: - First repetition

    func test_firstRepetition_rating5_interval1() {
        let (interval, ease) = SM2Calculator.calculate(
            rating: 5, easeFactor: 2.5, intervalDays: 0, repetitions: 0
        )
        XCTAssertEqual(interval, 1)
        XCTAssertGreaterThan(ease, 2.5, "Perfect recall must increase ease factor")
    }

    // MARK: - Second repetition

    func test_secondRepetition_rating4_interval6() {
        let (interval, _) = SM2Calculator.calculate(
            rating: 4, easeFactor: 2.5, intervalDays: 1, repetitions: 1
        )
        XCTAssertEqual(interval, 6)
    }

    // MARK: - Subsequent repetitions

    func test_thirdRepetition_rating4_intervalGrowth() {
        let (interval, ease) = SM2Calculator.calculate(
            rating: 4, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertGreaterThan(interval, 6, "Interval must grow after each successful review")
        XCTAssertEqual(ease, 2.5, accuracy: 0.01, "Rating 4 must keep ease unchanged")
    }

    func test_rating5_increasesEaseFactor() {
        let (_, ease) = SM2Calculator.calculate(
            rating: 5, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertGreaterThan(ease, 2.5)
    }

    func test_rating3_decreasesEaseFactor() {
        let (_, ease) = SM2Calculator.calculate(
            rating: 3, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertLessThan(ease, 2.5)
        XCTAssertGreaterThanOrEqual(ease, 1.3)
    }

    // MARK: - Ease factor floor

    func test_easeFactor_neverBelowFloor() {
        var ease = 1.5
        var interval = 1
        for _ in 0..<20 {
            let result = SM2Calculator.calculate(
                rating: 0, easeFactor: ease, intervalDays: interval, repetitions: 1
            )
            ease = result.newEaseFactor
            interval = result.newInterval
            XCTAssertGreaterThanOrEqual(ease, 1.3, "Ease factor must never drop below 1.3")
        }
    }

    // MARK: - Invalid rating

    func test_invalidRating_negative_treatedAsFailure() {
        let (interval, ease) = SM2Calculator.calculate(
            rating: -1, easeFactor: 2.5, intervalDays: 10, repetitions: 3
        )
        XCTAssertEqual(interval, 1)
        XCTAssertLessThanOrEqual(ease, 2.5)
    }

    func test_invalidRating_tooHigh_treatedAsFailure() {
        let (interval, _) = SM2Calculator.calculate(
            rating: 10, easeFactor: 2.5, intervalDays: 10, repetitions: 3
        )
        XCTAssertEqual(interval, 1)
    }
}

// MARK: - FreemiumGuardTests

final class FreemiumGuardTests: XCTestCase {

    // MARK: - canStartExam

    func test_freeUser_canStartExam_withinLimit() {
        XCTAssertTrue(
            FreemiumGuard.canStartExam(tier: .free, examCountForCertification: 0)
        )
        XCTAssertTrue(
            FreemiumGuard.canStartExam(tier: .free, examCountForCertification: 1)
        )
    }

    func test_freeUser_cannotStartExam_atLimit() {
        XCTAssertFalse(
            FreemiumGuard.canStartExam(tier: .free, examCountForCertification: 2)
        )
        XCTAssertFalse(
            FreemiumGuard.canStartExam(tier: .free, examCountForCertification: 10)
        )
    }

    func test_proUser_alwaysCanStartExam() {
        XCTAssertTrue(
            FreemiumGuard.canStartExam(tier: .pro, examCountForCertification: 100)
        )
    }

    func test_packUser_alwaysCanStartExam() {
        XCTAssertTrue(
            FreemiumGuard.canStartExam(tier: .pack, examCountForCertification: 50)
        )
    }

    // MARK: - maxQuestions

    func test_freeUser_maxQuestions_cappedAt20() {
        XCTAssertEqual(FreemiumGuard.maxQuestions(tier: .free, requested: 60), 20)
        XCTAssertEqual(FreemiumGuard.maxQuestions(tier: .free, requested: 10), 10)
        XCTAssertEqual(FreemiumGuard.maxQuestions(tier: .free, requested: 20), 20)
        XCTAssertEqual(FreemiumGuard.maxQuestions(tier: .free, requested: 21), 20)
    }

    func test_proUser_maxQuestions_unlimited() {
        XCTAssertEqual(FreemiumGuard.maxQuestions(tier: .pro, requested: 100), 100)
    }

    func test_packUser_maxQuestions_unlimited() {
        XCTAssertEqual(FreemiumGuard.maxQuestions(tier: .pack, requested: 350), 350)
    }
}
