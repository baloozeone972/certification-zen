// certif-parent/certif-ios/SM2CalculatorTests.swift
//
// Unit tests for SM2Calculator — pure domain logic, no mocks needed.
// Mirrors Java SM2AlgorithmServiceTest.java in certif-domain module.

import XCTest
@testable import CertifApp

final class SM2CalculatorTests: XCTestCase {

    // MARK: - Failed recall (rating < 3)

    func test_rating0_resetsInterval() {
        let (interval, ease) = SM2Calculator.calculate(
            rating: 0, easeFactor: 2.5, intervalDays: 10, repetitions: 3
        )
        XCTAssertEqual(interval, 1, "Rating 0 (blackout) must reset interval to 1")
        XCTAssertGreaterThanOrEqual(ease, SM2Calculator.minEaseFactor,
                                    "Ease factor must not drop below 1.3")
    }

    func test_rating1_resetsInterval() {
        let (interval, _) = SM2Calculator.calculate(
            rating: 1, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertEqual(interval, 1)
    }

    func test_rating2_resetsInterval() {
        let (interval, _) = SM2Calculator.calculate(
            rating: 2, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertEqual(interval, 1)
    }

    // MARK: - Ease factor NOT changed on failure (SM-2 spec)

    func test_failedRecall_efUnchanged() {
        let ef: Double = 2.5
        let (_, newEF) = SM2Calculator.calculate(
            rating: 1, easeFactor: ef, intervalDays: 6, repetitions: 2
        )
        XCTAssertEqual(newEF, ef, accuracy: 0.001,
                       "SM-2 spec: EF unchanged on failure")
    }

    // MARK: - First repetition (rep=0)

    func test_firstRepetition_rating5_interval1() {
        let (interval, ease) = SM2Calculator.calculate(
            rating: 5, easeFactor: 2.5, intervalDays: 0, repetitions: 0
        )
        XCTAssertEqual(interval, 1)
        XCTAssertGreaterThan(ease, 2.5, "Perfect recall must increase ease factor")
    }

    // MARK: - Second repetition (rep=1)

    func test_secondRepetition_rating4_interval6() {
        let (interval, _) = SM2Calculator.calculate(
            rating: 4, easeFactor: 2.5, intervalDays: 1, repetitions: 1
        )
        XCTAssertEqual(interval, 6)
    }

    // MARK: - Subsequent repetitions (rep >= 2)

    func test_thirdRepetition_intervalGrowth() {
        let ef = 2.5
        let prevInterval = 6
        let (interval, _) = SM2Calculator.calculate(
            rating: 4, easeFactor: ef, intervalDays: prevInterval, repetitions: 2
        )
        let expected = Int((Double(prevInterval) * ef).rounded())
        XCTAssertEqual(interval, expected)
    }

    func test_rating5_increasesEaseFactor() {
        let (_, ease) = SM2Calculator.calculate(
            rating: 5, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertGreaterThan(ease, 2.5)
    }

    func test_rating4_keepsEaseFactor() {
        let (_, ease) = SM2Calculator.calculate(
            rating: 4, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertEqual(ease, 2.5, accuracy: 0.001, "Rating 4 must keep ease unchanged")
    }

    func test_rating3_decreasesEaseFactor() {
        let (_, ease) = SM2Calculator.calculate(
            rating: 3, easeFactor: 2.5, intervalDays: 6, repetitions: 2
        )
        XCTAssertLessThan(ease, 2.5)
        XCTAssertGreaterThanOrEqual(ease, SM2Calculator.minEaseFactor)
    }

    // MARK: - Ease factor floor

    func test_easeFactor_neverBelowFloor() {
        var ease: Double = 1.5
        var interval = 1
        var repetitions = 0
        for _ in 0..<20 {
            let result = SM2Calculator.calculate(
                rating: 3, easeFactor: ease,
                intervalDays: interval, repetitions: repetitions
            )
            ease = result.easeFactor
            interval = result.interval
            repetitions += 1
        }
        XCTAssertGreaterThanOrEqual(ease, SM2Calculator.minEaseFactor,
                                    "EF must never drop below \(SM2Calculator.minEaseFactor)")
    }

    // MARK: - Perfect review streak

    func test_perfectStreak_intervalGrows() {
        var ease = 2.5
        var interval = 0
        var reps = 0
        for _ in 0..<10 {
            let result = SM2Calculator.calculate(
                rating: 5, easeFactor: ease,
                intervalDays: interval, repetitions: reps
            )
            ease = result.easeFactor
            interval = result.interval
            reps += 1
        }
        XCTAssertGreaterThan(interval, 6, "After 10 perfect reviews interval should be well above 6")
    }
}
