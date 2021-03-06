import ring_theory.matrix

local infixl ` *ₘ ` : 70 := matrix.mul

variables {α : Type} {n m l : Type} [fintype n] [fintype m] [fintype l]

section matrix
def le [partial_order α] (M N : matrix n m α)  :=
∀i:n, ∀j:m, M i j ≤ N i j

instance [partial_order α] : has_le (matrix n m α) :=
{
  le := le
}

def matrix.eq [partial_order α] (M N : matrix n m α) :=
∀i:n, ∀j:m, M i j = N i j

instance [partial_order α] : has_equiv (matrix n m α) :=
{
  equiv := eq
}

protected def matrix.le_refl [partial_order α] (A: matrix n m α) :
A ≤ A :=
begin
  assume i: n,
  assume j: m,
  refl
end

protected def matrix.le_trans [partial_order α] (a b c: matrix n m α) :
a ≤ b → b ≤ c → a ≤ c :=
begin
  assume h1: a ≤ b,
  assume h2: b ≤ c,
  assume i: n,
  assume j: m,
  have h1l: a i j ≤ b i j, from h1 i j,
  have h2l: b i j ≤ c i j, from h2 i j,
  transitivity,
  apply h1l,
  apply h2l,
end

protected def matrix.le_antisymm [partial_order α] (a b: matrix n m α) :
a ≤ b → b ≤ a → a = b :=
begin
  assume h1: a ≤ b,
  assume h2: b ≤ a,
  sorry -- no idea how I destruct the '=' here. I introduced above the
        -- definitions of matrix.eq and has_equiv, but I am not sure
        -- if these make sense.
end


instance [partial_order α] : partial_order (matrix n m α) :=
{
  le := le,
  le_refl := matrix.le_refl,
  le_trans := matrix.le_trans,
  le_antisymm := matrix.le_antisymm
}

end matrix

def polyhedron [ordered_ring α] (A : matrix m n α) (b : matrix m unit α) :
  set (matrix n unit α) :=
{ x : matrix n unit α | A *ₘ x ≥ b }
