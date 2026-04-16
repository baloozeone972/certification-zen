// certif-parent/certif-android/app/src/test/java/com/certifapp/android/HomeViewModelTest.kt
package com.certifapp.android

import com.certifapp.android.domain.model.Certification
import com.certifapp.android.domain.repository.CertificationRepository
import com.certifapp.android.ui.screen.home.HomeUiState
import com.certifapp.android.ui.screen.home.HomeViewModel
import io.mockk.*
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.flowOf
import kotlinx.coroutines.test.*
import org.junit.After
import org.junit.Assert.*
import org.junit.Before
import org.junit.Test

@OptIn(ExperimentalCoroutinesApi::class)
class HomeViewModelTest {

    private val dispatcher  = StandardTestDispatcher()
    private val repository  = mockk<CertificationRepository>()
    private lateinit var viewModel: HomeViewModel

    @Before
    fun setUp() {
        Dispatchers.setMain(dispatcher)
        coEvery { repository.refreshCertifications() } just runs
    }

    @After
    fun tearDown() { Dispatchers.resetMain() }

    @Test
    fun `init loads certifications successfully`() = runTest {
        val certs = listOf(buildCert("ocp21", "OCP Java 21"))
        every { repository.getCertifications() } returns flowOf(certs)

        viewModel = HomeViewModel(repository)
        advanceUntilIdle()

        val state = viewModel.uiState.value
        assertTrue(state is HomeUiState.Success)
        assertEquals(1, (state as HomeUiState.Success).certifications.size)
        assertEquals("ocp21", state.certifications[0].id)
    }

    @Test
    fun `empty list keeps loading state`() = runTest {
        every { repository.getCertifications() } returns flowOf(emptyList())

        viewModel = HomeViewModel(repository)
        advanceUntilIdle()

        assertTrue(viewModel.uiState.value is HomeUiState.Loading)
    }

    private fun buildCert(id: String, name: String) = Certification(
        id, "1Z0-830", name, null, 500, 80, 68, 180, "MCQ", emptyList(), true)
}
